# frozen_string_literal: true

require 'diff-lcs'
require 'diffy'
require 'stringio'
require 'uri'

module RSpec
  module HttpHelpers
    # @api private
    class HttpQuerystringMatcher

      def initialize(expected, colorize: true)
        @expected = querystring_from(expected)
        @diff_format = colorize ? :color : :text
      rescue ArgumentError => error
        raise "Invalid expected value: #{error.message}"
      end

      def matches?(actual)
        @actual = querystring_from(actual)
        @expected == @actual
      rescue ArgumentError
        got = actual.is_a?(String) ? actual : actual.class
        @wrong_type_error_message = 'expected URI with querystring ' \
          "matching #{@expected} got #{got}"
        false
      end

      def failure_message
        @wrong_type_error_message || diff_error_message
      end

      def failure_message_when_negated
        "expected querystring not to match #{@expected}"
      end

      private

      def uri_from(value)
        case value
        when nil then URI.parse('')
        when /^http/ then URI.parse(value)
        when /\?/ then URI.parse(value)
        when String then URI.parse("?#{value}")
        when URI::Generic then value
        else
          raise ArgumentError, "expected String<URI> or URI, got #{value.class}"
        end
      end

      def querystring_from(value)
        HttpHelpers.normalize_querystring(uri_from(value).query)
      end

      def diff_error_message
        message = StringIO.new
        message << "expected: #{@expected}\n\n"
        message << "got: #{@actual}\n\n"
        message << "Diff:\n#{diff}"
        message.string
      end

      def diff
        expected = @expected.split('&').join("\n") + "\n"
        actual = @actual.split('&').join("\n") + "\n"
        Diffy::Diff.new(expected, actual).to_s(@diff_format)
      end

    end
  end
end

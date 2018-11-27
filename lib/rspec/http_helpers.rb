# frozen_string_literal: true

require_relative 'http_helpers/http_querystring_matcher'

module RSpec
  # RSpec matchers for HTTP requests and responses
  module HttpHelpers
    # @param [String<HTTP Query>] expected
    # @raise [ArgumentError] Raises an ArgumentError if expected is
    #   not nil or a String.
    def match_http_querystring(expected)
      HttpQuerystringMatcher.new(expected)
    end

    class << self

      # @api private
      def normalize_querystring(query)
        return '' if query.nil?

        parts = query.split('&')
        parts = parts.sort_by do |param|
          name, actual_value = param.split('&')
          value = actual_value.nil? ? '' : actual_value
          [name, value, actual_value ? 1 : 0]
        end
        parts.join('&')
      end

    end
  end
end

RSpec.configure do |config|
  config.include RSpec::HttpHelpers
end

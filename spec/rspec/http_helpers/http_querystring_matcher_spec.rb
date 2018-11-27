# frozen_string_literal: true

require 'uri'

module RSpec
  module HttpHelpers
    describe HttpQuerystringMatcher do
      it 'fails when querystring values are not equal' do
        expect do
          expect('abc=xyz').to match_http_querystring('foo=bar')
        end.to raise_error(RSpec::Expectations::ExpectationNotMetError)
      end

      it 'passes when querystring values are equal' do
        expect('foo=bar').to match_http_querystring('foo=bar')
      end

      it 'extracts querystrings from URI fragment strings' do
        expect('?foo=bar').to match_http_querystring('foo=bar')
      end

      it 'parses querystrings from HTTP URIs' do
        expect('http://foo.com?foo=bar').to match_http_querystring('foo=bar')
      end

      it 'does not mistake http prefixed query params' do
        expect('https://foo.com?http=value').to match_http_querystring('http=value')
      end

      it 'parses querystrings from HTTPS URIs' do
        expect('https://foo.com?foo=bar').to match_http_querystring('foo=bar')
      end

      it 'extracts querystrings from URI objects' do
        uri = URI.parse('https://foo.com?foo=bar')
        expect(uri).to match_http_querystring('foo=bar')
      end

      it 'it compares querystring indifferently of order' do
        expected = 'abc=xyz&foo=bar'
        actual = 'foo=bar&abc=xyz'
        expect(actual).to match_http_querystring(expected)
      end

      it 'it supports querystrings with repeated params' do
        expected = 'abc=2&abc=1&abc=&abc'
        actual = 'abc&abc=2&abc=&abc=1'
        expect(actual).to match_http_querystring(expected)
      end

      it 'supports expected strings with full urls' do
        expected = 'https://foo.com?abc=xyz'
        actual = 'abc=xyz'
        expect(actual).to match_http_querystring(expected)
      end

      it 'supports actual strings with full urls' do
        expected = 'abc=xyz'
        actual = 'https://foo.com?abc=xyz'
        expect(actual).to match_http_querystring(expected)
      end

      it 'considers empty querystrings to be the same as nil values' do
        expected = ''
        actual = nil
        expect(actual).to match_http_querystring(expected)
      end

      it 'provides a helpful diff when the querystring values do not match' do
        expected = 'foo=bar&abc=xyz'
        actual = 'foo=Bar&abc=xyz'
        # Using matcher class to disable the colorized message
        matcher = HttpQuerystringMatcher.new(expected, colorize: false)
        matcher.matches?(actual) # false
        expect(matcher.failure_message).to eq(<<~MESSAGE)
          expected: abc=xyz&foo=bar

          got: abc=xyz&foo=Bar

          Diff:
           abc=xyz
          -foo=bar
          +foo=Bar
        MESSAGE
      end

      it 'raises an error when the actual value is not a supported type' do
        expected = 'foo=bar'
        actual = {}
        expect do
          expect(actual).to match_http_querystring(expected)
        end.to raise_error('expected URI with querystring matching foo=bar got Hash')
      end

      it 'raises an error when the expected value is not a supported type' do
        expected = {}
        actual = ''
        expect do
          expect(actual).to match_http_querystring(expected)
        end.to raise_error('Invalid expected value: expected String<URI> or URI, got Hash')
      end

      it 'implements a basic negation error message' do
        expect do
          expect('abc=xyz').not_to match_http_querystring('abc=xyz')
        end.to raise_error('expected querystring not to match abc=xyz')
      end
    end
  end
end

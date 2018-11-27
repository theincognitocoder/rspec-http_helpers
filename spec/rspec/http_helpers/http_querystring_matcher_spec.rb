# frozen_string_literal: true

module RSpec
  module HttpHelpers
    describe HttpQuerystringMatcher do
      it 'returns true when querystring values are equal' do
        matcher = HttpQuerystringMatcher.new('foo=bar')
        expect(matcher.matches?('foo=bar')).to be(true)
      end

      it 'returns false when querystring values are not equal' do
        matcher = HttpQuerystringMatcher.new('foo=bar')
        expect(matcher.matches?('abc=xyz')).to be(false)
      end

      it 'it compares querystring indifferently of order' do
        expected = 'abc=xyz&foo=bar'
        actual = 'foo=bar&abc=xyz'
        matcher = HttpQuerystringMatcher.new(expected)
        expect(matcher.matches?(actual)).to be(true)
      end

      it 'it supports querystrings with repeated params' do
        expected = 'abc=2&abc=1&abc=&abc'
        actual = 'abc&abc=2&abc=&abc=1'
        matcher = HttpQuerystringMatcher.new(expected)
        expect(matcher.matches?(actual)).to be(true)
      end

      it 'supports expected strings with full urls' do
        expected = 'https://foo.com?abc=xyz'
        actual = 'abc=xyz'
        matcher = HttpQuerystringMatcher.new(expected)
        expect(matcher.matches?(actual)).to be(true)
      end

      it 'supports actual strings with full urls' do
        expected = 'abc=xyz'
        actual = 'https://foo.com?abc=xyz'
        matcher = HttpQuerystringMatcher.new(expected)
        expect(matcher.matches?(actual)).to be(true)
      end

      it 'considers empty querystrings to be the same as nil values' do
        expected = ''
        actual = nil
        matcher = HttpQuerystringMatcher.new(expected)
        expect(matcher.matches?(actual)).to be(true)
      end

      it 'provides a helpful diff when the querystring values do not match' do
        expected = 'foo=bar&abc=xyz'
        actual = 'foo=Bar&abc=xyz'
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

      it 'provides a helpful failure message when actual is the wrong type' do
        matcher = HttpQuerystringMatcher.new('foo=bar')
        matcher.matches?({})
        expect(matcher.failure_message).to eq('expected URI with querystring matching foo=bar got Hash')
      end

      it 'raises an error when the expected value is not a string' do
        expect do
          HttpQuerystringMatcher.new({})
        end.to raise_error(ArgumentError, 'expected String<URI> or URI, got Hash')
      end

      it 'is available as an rspec matcher' do
        expect('https://foo.com?abc=xyz').to match_http_querystring('abc=xyz')
      end
    end
  end
end

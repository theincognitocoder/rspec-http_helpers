# Rspec Http Helpers

[![Build Status](https://travis-ci.org/theincognitocoder/rspec-http_helpers.svg?branch=master)](https://travis-ci.org/theincognitocoder/rspec-http_helpers)
[![Coverage Status](https://coveralls.io/repos/github/theincognitocoder/rspec-http_helpers/badge.svg?branch=master)](https://coveralls.io/github/theincognitocoder/rspec-http_helpers?branch=master)
[![Maintainability](https://api.codeclimate.com/v1/badges/f9ac56f41cd6333d98ee/maintainability)](https://codeclimate.com/github/theincognitocoder/rspec-http_helpers/maintainability)

Rspec Http Helpers

## Links of Interest

* [Documentation](https://www.rubydoc.info/github/theincognitocoder/rspec-http_helpers/master)
* [Changelog](https://github.com/theincognitocoder/rspec-http_helpers/blob/master/CHANGELOG.md)

## Installation

Add rspec-http_helpers to your project's Gemfile and then bundle install.

    gem 'rspec-http_helpers', '~> 1.0'

## Basic Usage

Require from your spec helper:

    # spec/spec_helper.rb

    require 'rspec/http_helpers'

Then use a matcher from your specs:

    it '...' do
      expect('https://foo.com?abc=xyz').to match_http_querystring('abc=xyz')
    end

## License

MIT License

Copyright 2018 The Incognito Coder

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is furnished
to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

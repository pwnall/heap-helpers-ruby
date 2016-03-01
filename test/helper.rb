if RUBY_VERSION >= '1.9'  # simplecov only works on MRI 1.9+
  require 'simplecov'
  require 'coveralls'

  module SimpleCov::Configuration
    def clean_filters
      @filters = []
    end
  end

  SimpleCov.configure do
    clean_filters
    load_adapter 'test_frameworks'
  end

  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::HTMLFormatter,
    Coveralls::SimpleCov::Formatter
  ]

  ENV["COVERAGE"] && SimpleCov.start do
    add_filter "/.rvm/"
  end
end

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'minitest/autorun'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'heap-helpers'

# We need String#html_safe.
require 'active_support/core_ext/string/output_safety'

class MiniTest::Test
end

MiniTest.autorun

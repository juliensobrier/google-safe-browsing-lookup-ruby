require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'test/unit'
require 'shoulda'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'google-safe-browsing-lookup'

class Test::Unit::TestCase
end

class MockClient < SafeBrowsingLookup
	def errors(urls=[])
		super(urls)
	end

	def ok(urls=[])
		super(urls)
	end

	def parse(urls=[], response)
		super(urls, response)
	end
end

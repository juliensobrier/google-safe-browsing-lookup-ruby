require 'helper'

class TestGoogleSafeBrowsingLookup < Test::Unit::TestCase
  	context "Lookup client" do
    	setup do
      		@client = SafeBrowsingLookup.new('put_the_Google_API_key_here')
	  		@mock = MockClient.new('put_the_Google_API_key_here')
    	end


		should "create a hash URL => 'error'" do
			results = @mock.errors(['http://www.google.com/', 'http://www.google.org/'])

			assert_equal 2, 		results.length, 					"Number of keys should match number of URLs"
			assert_equal 'error', 	results['http://www.google.com/'], 	"An error should be returned"
			assert_equal 'error', 	results['http://www.google.org/'], 	"An error should be returned"
		end

		should "create a hash URL => 'ok'" do
			results = @mock.ok(['http://www.google.com/', 'http://www.google.org/'])

			assert_equal 2, 	results.length, 						"Number of keys should match number of URLs"
			assert_equal 'ok', 	results['http://www.google.com/'], 		"ok should be returned"
			assert_equal 'ok', 	results['http://www.google.org/'], 		"ok should be returned"
		end

		should "parse the server response" do
			response = "ok\nphishing"

			results = @mock.parse(['http://www.google.com/', 'http://www.google.org/'], response)

			assert_equal 2, 			results.length, 					"Number of keys should match number of URLs"
			assert_equal 'ok', 			results['http://www.google.com/'], 	"ok should be returned"
			assert_equal 'phishing', 	results['http://www.google.org/'], 	"phishing should be returned"
		end

		should "create find an error with server response" do
			response = "ok\nphishing\nok"

			results = @mock.parse(['http://www.google.com/', 'http://www.google.org/'], response)

			assert_equal 2, 		results.length, 					"Number of keys should match number of URLs"
			assert_equal 'error', 	results['http://www.google.com/'], 	"An error should be returned"
			assert_equal 'error', 	results['http://www.google.org/'], 	"An error should be returned"
		end

		should "do live tests" do
			if (@client.key == 'put_the_Google_API_key_here')
				return # An valid key is required
			end

			results = @client.lookup('http://www.gumblar.cn/')
			assert_equal 1, 		results.length, 					"Number of keys should match number of URLs"
			assert_equal 'malware', results['http://www.gumblar.cn/'], 	"malware should be returned"
		end

		should "send more than 500 URLs" do
			if (@client.key == 'put_the_Google_API_key_here')
				return # An valid key is required
			end

			urls = []
			(1..600).each do |id|
				urls.push("http://www.gumblar.cn/#{id}")
			end

			results = @client.lookup(urls)
			assert_equal urls.length, 	results.length, 					"Number of keys should match number of URLs"
			assert_equal 'malware', 	results['http://www.gumblar.cn/1'], "malware should be returned"
		end
  	end
end

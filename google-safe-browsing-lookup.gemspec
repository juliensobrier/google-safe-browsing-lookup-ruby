Gem::Specification.new do |s|
  s.name        = 'google-safe-browsing-lookup'
  s.version     = '0.2.0'
  s.date        = '2015-02-28'
  s.summary     = "Library for the Google Saf Browsing Lookup API",
  s.description = "Google Safe Browsing v3 Lookup is a lighter alternative to the full API. The service allows users to check up to 10,000 URLs a day against their list og phishing and malicious sites. A free API key is required."
  s.authors     = ["Julien Sobrier"]
  s.email       = 'julien@sobrier.net'
  s.files       = ["Gemfile", "Rakefile", "lib/google-safe-browsing-lookup.rb"]
  s.require_paths = ["lib"]
  s.test_files  = ["test/helper.rb", "test/test_google-safe-browsing-lookup.rb"]
  s.homepage    = 'https://github.com/juliensobrier/google-safe-browsing-lookup-ruby'
  s.license     = 'MIT'
  s.add_development_dependency "bundler", "~> 1.5"
  s.add_development_dependency "rake"
  s.add_development_dependency "shoulda"
  s.add_development_dependency "yard"
end
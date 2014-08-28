require 'lib/file_convert/version'

Gem::Specification.new do |s|
  s.platform      = Gem::Platform::RUBY
  s.name          = 'file-convert'
  s.version       = FileConvert::Version::STRING
  s.summary       = 'Instrumentalize Google Drive to convert files'
  s.description   = 'Uses google-api-ruby-client and Google Drive to convert files from one mime-type to another'

  s.author        = 'Roman Ernst'
  s.email         = 'rernst@farbenmeer.net'
  s.license       = 'CC BY-SA 3.0'
  s.homepage      = 'https://github.com/tolingo/file-convert'
  s.files         = Dir['README.md', 'lib/**/*', 'config/file_convert.yml']
  s.require_path  = 'lib'

  s.required_ruby_version = Gem::Requirement.new '>= 1.9.2'

  s.add_dependency 'google-api-client', '~> 0.7.0'
end

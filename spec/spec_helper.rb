require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')
$LOAD_PATH << File.join(File.dirname(__FILE__))

require 'rubygems'
require 'rspec'
require 'pry'

require 'file_convert'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    # This option will default to `true` in RSpec 4.
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_doubled_constant_names = true
    mocks.verify_partial_doubles = true
    mocks.syntax = [:expect]
    # Prevents you from mocking or stubbing a method that does not exist on
    # a real object. This is generally recommended, and will default to
    # `true` in RSpec 4.
    mocks.verify_partial_doubles = true
  end
end

require 'rubygems'

require 'rspec'
require 'rspec/mocks'
require 'rb-fsevent'
  
include RSpec::Mocks::ExampleMethods

require 'scale'
include Scale

RSpec.configure do |config|
  config.filter_run_excluding :pending => true
  config.fail_fast = true
  config.mock_with :rspec
  config.profile_examples = true
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
end

=begin
  [Cm.root(:D).chord, Cm.root(4).chord]
=end

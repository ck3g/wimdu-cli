require_relative "support/cli_process"
require 'wimdu'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.filter_run :focus
  config.run_all_when_everything_filtered = true
  config.disable_monkey_patching!

  # data_mapper generates huge amount of warnings
  # There is issue openned for years: https://github.com/datamapper/dm-core/issues/172
  # config.warnings = true

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  config.order = :random

  Kernel.srand config.seed

  config.before do
    Wimdu::DbConnection.init!('test_')
    DataMapper.auto_migrate!
  end
end

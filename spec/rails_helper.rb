ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
abort("Refusing to run specs in production") if Rails.env.production?
require "rspec/rails"

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.fail_if_no_examples = true
end

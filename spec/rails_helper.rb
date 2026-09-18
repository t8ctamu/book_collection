ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
abort("Refusing to run specs in production") if Rails.env.production?
require "rspec/rails"

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include Devise::Test::IntegrationHelpers, type: :request
  config.before(:each, type: :request) do |example|
    unless example.metadata[:unauthenticated]
      sign_in Admin.create!(uid: "test-user", email: "reader@example.com", full_name: "Test Reader")
    end
  end
  config.use_transactional_fixtures = true
  config.fail_if_no_examples = true
end

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/rails'
require 'minitest/rails/railtie'

# Uncomment for awesome colorful output
require "minitest/pride"

Dir[Rails.root.join('test', 'support', '*.rb')].each { |f| require f }

class ActiveSupport::TestCase
  # include Warden::Test::Helpers
  include Auth

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  ActiveRecord::Migration.check_pending!
end

ActionController::TestCase.send(:include, Devise::TestHelpers)
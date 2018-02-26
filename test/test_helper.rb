ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/reporters"
Minitest::Reporters.use!
module ActiveSupport
  class TestCase
    fixtures :all
    include ApplicationHelper
  end
end

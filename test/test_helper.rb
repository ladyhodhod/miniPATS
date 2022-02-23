require 'simplecov'
SimpleCov.start 'rails'
ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
# Minitest is a testing framework that supports TDD and BDD approaches, mocking, and benchmarking.
# You can use the older versions and launch tests from the console, but RubyMine’s GUI actions will be unavailable.

require "minitest"
require 'minitest/rails'
require 'minitest/reporters'


require 'minitest_extensions' # makes the test messages a little bit more verbose


require 'contexts'


class ActiveSupport::TestCase
  # Fixtures are data that you can feed into your unit testing. 
  # They are automatically created whenever rails generates the corresponding tests
  #  for your controllers and models. They are only 
  # used for your tests and cannot actually be accessed when running the application.
  # Since we are not using fixtures, comment this line out. We will be using FactoryBot instead!

  # fixtures :all

  # Add more helper methods to be used by all tests here...
  include Contexts

  # Add the infamous deny method...
  def deny(condition, msg="")
    # a simple transformation to increase readability IMO
    assert !condition, msg
  end


  # Spruce up minitest results...
  Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new]
end

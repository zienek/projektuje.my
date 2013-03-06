ENV['RACK_ENV'] = 'test'

require File.join(File.dirname(__FILE__), '..', '..', 'app.rb')

require 'capybara'
require 'capybara/cucumber'
require 'capybara/webkit'
require 'capybara-screenshot'
require 'capybara-screenshot/cucumber'
require 'rspec'
require 'cucumber/rspec/doubles'


Capybara.app = Sinatra::Application

Capybara.default_driver = :webkit
Capybara.javascript_driver = :webkit # Faster ajax tests.
Capybara::Screenshot.autosave_on_failure = true # Disable automatic screenshots.

class MyWorld
  include Capybara::DSL
  include RSpec::Expectations
  include RSpec::Matchers
  include RSpec::Mocks::ExampleMethods
end

World do
  MyWorld.new
end
require 'rubygems'
require 'bundler'
Bundler.setup :default, :test

require 'rack/test'

# Load app
require_relative '../app.rb'
Dir["#{File.dirname(__FILE__)}/../app/**/*.rb"].each { |file| require file }

# Load support
Dir["#{File.dirname(__FILE__)}/support/*.rb"].each { |file| require file }

I18n.enforce_available_locales = false

RSpec.configure do |config|
  # Use color in STDOUT
  config.color = true
  # Use the specified formatter
  config.formatter = :documentation # :progress, :html, :textmate

  config.include Rack::Test::Methods
  config.raise_errors_for_deprecations!

  config.before(:each) { Grape::Util::InheritableSetting.reset_global! }
end

require 'rubygems'
require 'rack/cors'
require 'bundler/setup'
require File.expand_path '../app.rb', __FILE__

use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: [:get, :post, :put, :delete, :options]
  end
end

run API::V1

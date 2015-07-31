require 'rake'
require_relative 'app'

desc 'Show grape api routes'
task :routes do
  API::V1.routes.each do |route|
    method = route.route_method.ljust(10)
    path = route.route_path
    puts "     #{method} #{path}"
  end
end


desc 'Run rspec with jruby settings'
task :spec do
  system 'mvn process-sources'
  system 'jruby -J-Xmx2048m -S rspec'
end

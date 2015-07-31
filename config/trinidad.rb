Trinidad.configure do |config|
  # Server options
  config.port = 3000
  config.address = '0.0.0.0'

  # Application options
  config.jruby_min_runtimes = 1
  config.jruby_max_runtimes = 1
  config.java_lib = 'lib/java'
  config.java_classes = 'lib/java/classes'
end

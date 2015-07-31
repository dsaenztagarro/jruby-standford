require 'torquebox-capistrano-support'
require 'bundler/capistrano'

set :application, 'rb_nlp_service'
set :scm, :git
set :scm_verbose, true
set :repository, 'git@github.com:dsaenztagarro/jruby-standford.git'
set :user, 'deployer'
set :use_sudo, false

set :shared_children, shared_children + %w{lib/java}

set :deploy_to, '/www/deploy'
set :torquebox_home, '/usr/local/torquebox'

set :keep_releases, 5
after 'deploy:update', 'deploy:cleanup'

role :web, 'stanford.dev'

after 'deploy:create_symlink', 'deploy:install_maven_dependencies'

namespace :deploy do
  task :install_maven_dependencies do
    run "cd #{release_path}; mvn process-sources"
  end
end

ssh_options[:keys] = [File.join(ENV['HOME'], '.ssh', 'id_rsa')]

task :staging do
  # server 'staging.standford.com', :web, primary: true
end

task :production do
  # server 'production.standford.com', :web, primary: true
end
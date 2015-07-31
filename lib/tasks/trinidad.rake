namespace :trinidad do
  desc 'Start Trinidad server (as daemon in production)'
  task :start, :environment do |t, args|
    env = args['environment'] || 'production'
    if env == 'production'
      cmd = 'jruby -J-Xmx2048m -J-Xms1024m -J-Xmn512m -J-XX:MaxPermSize=512m ' \
            '--server -S rackup ' \
            '--host 0.0.0.0 --pid tmp/pids/server.pid --daemonize ' \
            '--env production --server Trinidad'
    else
      # cmd = 'jruby --debug -J-Xmx2048m --server -S rackup --host 0.0.0.0 --env production --server Trinidad'
      cmd = 'jruby --debug -J-Xmx2048m --server -S trinidad --threadsafe'
      # cmd = 'jruby --debug -J-Xmx2048m --server -S trinidad'
    end
    system(cmd)
  end

  desc 'Stop Trinidad server daemon'
  task :stop do
    pid_file = 'tmp/pids/server.pid'
    pid = File.read(pid_file).to_i
    Process.kill 9, pid
    File.delete pid_file
  end
end

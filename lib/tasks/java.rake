namespace :java do
  desc 'Example to run java app with Stanford API'
  task :test_app do
    classpath = Dir.glob('lib/java/*.jar').map { |dir| "../#{dir}:" }.join
    cmd = "cd examples;\n" \
          "javac -cp #{classpath} StandfordNLPTest.java;\n" \
          "java -cp #{classpath} StandfordNLPTest"
    puts cmd
    system(cmd)
  end
end

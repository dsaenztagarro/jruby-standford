set -x
export TORQUEBOX_HOME=~/torquebox-3.1.1
export JBOSS_HOME=$TORQUEBOX_HOME/jboss
export JRUBY_HOME=$TORQUEBOX_HOME/jruby
export PATH=$JRUBY_HOME/bin:$PATH

torquebox deploy
torquebox run -b 0.0.0.0 -p 3000

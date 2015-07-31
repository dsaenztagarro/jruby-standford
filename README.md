# rb_standford_nlp

# Install

```shell
$ rvm install jruby-1.7.13
$ rvm use jruby-1.7.13@global

# Download and install java library dependencies
mvn process-sources
```

# Quality code

The JRuby-Lint3 tool can detect most JRuby
incompatibilities in an application. It runs through the code base and looks
for common gotchas

```shell
jrlint
```

# Up server

```
jruby -S rackup -s Trinidad
jruby -J-Xmx2048m -J-Xms1024m -J-Xmn512m -J-XX:MaxPermSize=512m -S rackup -s Trinidad
```

```
# Create war
warble war

# Check war content
jar xvf nlp_service.war
```

# Generate Docker image

## Sharing folders in containers

```
# Make a volume container
$ docker run -v /data --name my-data busybox true
# Share it using Samba (Windows file sharing)
$ docker run --rm -v /usr/local/bin/docker:/docker -v /var/run/docker.sock:/docker.sock svendowideit/samba my-data
# then find out the IP address of your Boot2Docker host
$ boot2docker ip
192.168.59.103
```

```
# Mac OS X 
boot2docker up
boot2docker ip

# Delete no tagged images
docker rmi $(docker images | grep "^<none>" | awk '{print $3}')

# Generate docker image
docker build --rm=true --no-cache=false -t dev/jruby .

# Run docker image
docker run --name stanford_nlp_service -p 3000:3000 dev/jruby
```

# Torquebox configuration

```
$ wget http://torquebox.org/release/org/torquebox/torquebox-dist/3.1.1/torquebox-dist-3.1.1-bin.zip
$ unzip torquebox-dist-3.1.1-bin.zip -d ~ 
$ export TORQUEBOX_HOME=~/torquebox-3.1.1
$ export JBOSS_HOME=$TORQUEBOX_HOME/jboss
$ export JRUBY_HOME=$TORQUEBOX_HOME/jruby
$ export PATH=$JRUBY_HOME/bin:$PATH
```

# Torquebox commands

```
torquebox deploy
torquebox run -b 0.0.0.0 -p 3000

# Update $JBOSS_HOME/bin/standalone.sh
SET JAVA_OPTS="$JAVA_OPTS -Xms1024m -Xmx2048m"
```

# Deployment

```
# Create shared folders (Only first time)
cap staging deploy:setup

cap staging deploy
```

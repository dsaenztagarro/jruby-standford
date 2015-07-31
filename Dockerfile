FROM phusion/baseimage:0.9.13

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

#Install Oracle JDK 8 and Node.js
RUN sudo add-apt-repository ppa:webupd8team/java
RUN sudo add-apt-repository ppa:chris-lea/node.js && sudo apt-get update
#This absurdity exists so that JDK is installed without prompting for license
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections

RUN sudo apt-get install -y --no-install-recommends oracle-java8-installer
RUN sudo apt-get install oracle-java8-set-default
RUN sudo apt-get install -y nodejs
RUN sudo apt-get autoremove -y && apt-get clean

ENV JRUBY_VERSION 1.7.13
#Get JRuby
RUN curl http://jruby.org.s3.amazonaws.com/downloads/$JRUBY_VERSION/jruby-bin-$JRUBY_VERSION.tar.gz | tar xz -C /opt

ENV PATH /opt/jruby-$JRUBY_VERSION/bin:./vendor/bundle:$PATH

RUN echo gem: --no-document >> /etc/gemrc

RUN gem update --system
RUN gem install bundler

#Add user
RUN addgroup --gid 9999 app
RUN adduser --uid 9999 --gid 9999 --disabled-password --gecos "Application" app
RUN usermod -L app
RUN mkdir -p /home/app/service
ADD . /home/app/service
RUN chown -R app:app /home/app/

USER app

#JRuby options
ENV PATH /opt/jruby-$JRUBY_VERSION/bin:$PATH
# RUN echo compat.version=2.0 > /home/app/.jrubyrc
# RUN echo invokedynamic.all=true >> /home/app/.jrubyrc

#Get Rails running
WORKDIR /home/app/service
# ENV RAILS_ENV staging
# RUN bundle exec rake db:reset
# RUN jruby -S bundle install --path vendor/bundle --deployment
RUN jruby -S bundle install --path vendor/bundle  --without test development

EXPOSE 3000

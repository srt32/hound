FROM phusion/passenger-ruby21

MAINTAINER Simon Taranto "simon.taranto@gmail.com"

ENV HOME /root

CMD ["/sbin/my_init"]

RUN rm -f /etc/service/nginx/down

RUN rm /etc/nginx/sites-enabled/default

ADD nginx.conf /etc/nginx/sites-enabled/hound.conf

RUN mkdir /home/app/hound

ADD . /home/app/hound
RUN chown -R app:app /home/app/hound

RUN ruby-switch --set ruby2.1

WORKDIR /tmp
ADD Gemfile /tmp/
ADD Gemfile.lock /tmp/

RUN bundle install --without development test

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

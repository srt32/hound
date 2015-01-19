FROM ubuntu

MAINTAINER Simon Taranto "simon.taranto@gmail.com"

RUN apt-get update -q
RUN apt-get install -qy nginx
RUN apt-get install -qy curl
RUN apt-get install -qy nodejs
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

RUN curl -sSL https://get.rvm.io | bash -s stable
RUN /bin/bash -l -c "rvm requirements"
RUN /bin/bash -l -c "rvm install 2.2.0"
RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"

ADD config/container/nginx-sites.conf /etc/nginx/sites-enabled/default
ADD config/container/start-server.sh /usr/bin/start-server
RUN chmod +x /usr/bin/start-server

ADD ./ /hound

WORKDIR /hound

RUN /bin/bash -l -c "bundle install --without development test"

EXPOSE 80

ENTRYPOINT /usr/bin/start-server

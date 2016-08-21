FROM phusion/passenger-ruby23:0.9.19

MAINTAINER Bagus Trihatmaja bagus.trihatmaja@gmail.com

# Set correct environment variables.
ENV HOME /root
# ENV PGUSER postgres
# ENV PGPASSWORD postgres
# ENV PGHOST localhost
# ENV REDISUSER 
# ENV REDISPASSWORD
# ENV REDISHOST

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]
EXPOSE 80

# If you're using the 'customizable' variant, you need to explicitly opt-in
# for features. Uncomment the features you want:
#
#   Build system and git.
RUN /build/utilities.sh
RUN /build/ruby2.3.sh
RUN apt-get install libpq-dev
RUN rm -f /etc/service/nginx/down
RUN rm /etc/nginx/sites-enabled/default

ADD config/salestock-test.conf /etc/nginx/sites-enabled/salestock-test.conf
ADD config/salestock-test-env.conf /etc/nginx/main.d/salestock-test-env.conf

WORKDIR /tmp
ADD salestock-test/Gemfile /tmp/
ADD salestock-test/Gemfile.lock /tmp/
RUN bundle install

RUN mkdir /home/app/salestock-test


ADD salestock-test /home/app/salestock-test
RUN chown -R app:app /home/app/salestock-test

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
# RUN echo "app    ALL=(ALL)    NOPASSWD:ALL" >> /etc/sudoers.d/app
# USER app
WORKDIR /home/app/salestock-test

FROM ruby:2.6.3

RUN apt-get update -qq && apt-get install -y dos2unix nodejs mysql-client default-libmysqlclient-dev
RUN gem install bundler

RUN mkdir /upload-ms
WORKDIR /upload-ms

ADD Gemfile /upload-ms/Gemfile
ADD Gemfile.lock /upload-ms/Gemfile.lock

RUN bundle install
ADD . /upload-ms

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
RUN dos2unix /usr/bin/entrypoint.sh && apt-get --purge remove -y dos2unix && rm -rf /var/lib/apt/lists/*
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000

# ENTRYPOINT ["bundle", "exec"]

# CMD ['bundle', 'exec', 'rails', 'server', '-b', '0.0.0.0']

CMD ["rails", "server", "-b", "0.0.0.0"]
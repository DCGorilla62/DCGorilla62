# Use the official Ruby image
FROM ruby:3.2

# Set environment variables
ENV LANG=C.UTF-8 \
    TZ=UTC \
    GEM_HOME=/usr/local/bundle

# Install dependencies
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs npm && \
    gem install jekyll bundler

# Set working directory
WORKDIR /srv/jekyll

# Copy Gemfiles first for cache efficiency
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install

# Copy the rest of the project
COPY . .

# Expose default Jekyll port
EXPOSE 4000

# Default command (can be overridden by docker-compose.yml)
CMD ["jekyll", "serve", "--host", "0.0.0.0"]

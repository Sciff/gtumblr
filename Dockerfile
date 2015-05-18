# use passenger with common image processing tools
FROM phusion/passenger-ruby21:0.9.12
MAINTAINER Alex Ivanov "walexjar@gmail.com"

# Set correct environment variables.
ENV HOME /home/app
ENV APP_PATH $HOME/webapp

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

# Setup nginx
RUN rm -f /etc/service/nginx/down
# add nginx configuration
ADD ./nginx.conf /etc/nginx/sites-enabled/default

# Add mysql envs (because nginx does clear all envs by default)
ADD ./mysql-env.conf /etc/nginx/main.d/mysql-env.conf

# Prepare folders
RUN mkdir $APP_PATH

# Copy the Gemfile and Gemfile.lock into the image.
# Temporarily set the working directory to where they are.
ADD ./Gemfile $APP_PATH/Gemfile
ADD ./Gemfile.lock $APP_PATH/Gemfile.lock
RUN chown app:app -R $APP_PATH
# bundle install before adding sources - results in cached bundle!
WORKDIR $APP_PATH
RUN su app -c "bundle install --path $APP_PATH/vendor/bundle"

# add main sources
ADD . $APP_PATH/
RUN chown app:app -R $APP_PATH

# add entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chown app:app /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
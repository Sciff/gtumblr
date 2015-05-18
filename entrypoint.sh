#!/bin/bash
set -e

# setup database and start sidekiq
cd $APP_PATH
su app -c "RAILS_ENV=production bundle exec rake db:create db:migrate"
su app -c "RAILS_ENV=production bundle exec rake assets:precompile"

exec "$@"
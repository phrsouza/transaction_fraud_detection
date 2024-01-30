#!/usr/bin/env bash
# exit on error
set -o errexit

RAILS_ENV=production bundle install
RAILS_ENV=production ./bin/rails db:migrate
RAILS_ENV=production ./bin/rails data:migrate
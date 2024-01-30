#!/usr/bin/env bash
# exit on error
set -o errexit

RAILS_ENV=production bundle install
RAILS_ENV=production ./bin/rails assets:precompile
RAILS_ENV=production ./bin/rails assets:clean
# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.1.2'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.1.2'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '>= 5.0'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem "jbuilder"

# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mswin mswin64 mingw x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin Ajax possible
# gem "rack-cors"

gem 'active_model_serializers'
gem 'apipie-rails'
gem 'data_migrate'
gem 'rack-attack'
gem 'rubocop', require: false
gem 'rubocop-factory_bot', require: false
gem 'rubocop-rails', require: false
gem 'rubocop-rspec', require: false

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mswin mswin64 mingw x64_mingw]
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem 'pry-byebug'
  gem 'rspec-rails', '~> 6.1.0'
  gem 'shoulda-matchers', '~> 6.0'
  gem 'timecop', '~> 0.9.8'
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"

  gem 'error_highlight', '~> 0.6.0'
end

group :test do
  gem 'simplecov', require: false
  gem 'simplecov-json', require: false
end

gem 'dockerfile-rails', '>= 1.5', group: :development

gem 'redis', '~> 5.0'

gem 'sentry-ruby', '~> 5.14'

gem 'sentry-rails', '~> 5.14'

gem 'slim-rails'
#gem 'nokogiri'

gem 'kaminari'
gem 'newrelic_rpm'

gem 'therubyracer'
gem 'less-rails'
gem 'twitter-bootstrap-rails'

gem 'devise'
gem 'cancan'

gem 'simple_form'
gem 'client_side_validations'
gem 'client_side_validations-simple_form'

gem 'rails-i18n'
gem 'devise-i18n'

gem_group :development, :test do
  gem 'rspec-rails'
  gem 'capybara'
  gem 'factory_girl_rails'
end

gem_group :assets do
  gem 'turbo-sprockets-rails3'
end

gem_group :development do
  gem 'capistrano'
  gem 'quiet_assets'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
end

run 'bundle install'


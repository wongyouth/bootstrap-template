gem 'slim-rails'
#gem 'nokogiri'
gem 'kaminari'
gem 'less-rails-bootstrap'
gem 'settingslogic'
gem 'therubyracer'

gem 'emblem-rails'
gem 'ember-rails'

gem 'devise'
gem 'cancan'

gem 'simple_form', '~> 3.0.0'
#gem 'client_side_validations'
#gem 'client_side_validations-simple_form'

gem 'rails-i18n'
gem 'devise-i18n'
# use gem > 0.2.5 for zh-CN translation
gem 'devise-i18n-views', git: 'https://github.com/mcasimir/devise-i18n-views.git'

#gem 'ckeditor'
gem "carrierwave"
gem "mini_magick"

gem_group :development, :test do
  gem 'debugger'
  gem 'awesome_print'
  gem 'rspec-rails'
  gem 'jasmine-rails', github: 'searls/jasmine-rails'
  gem 'factory_girl_rails'
  gem 'autotest'
  gem 'zeus'
end

gem_group :test do
  gem 'capybara'
  gem 'capybara-email'
  gem 'database_cleaner'
  gem 'selenium-webdriver'
  gem 'poltergeist'
  gem 'simplecov', :require => false
end

gem_group :development do
  gem 'guard-livereload'
  gem 'rack-livereload'
  gem 'capistrano'
  gem 'quiet_assets'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
  #gem 'turbo-sprockets-rails3' # conflict with emblem-rails
  gem 'thin'
  gem 'pry-rails'
  gem 'pry-nav'
end

gem_group :production do
  gem 'newrelic_rpm'
end

run 'bundle install'


def template_file path
  template_path = File.expand_path("../templates/#{path}", __FILE__)
  template_path = template_path.scan(/https:.*/).first if template_path =~ /https:/
  file path, open(template_path).read
end

# template.rb

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

generate('devise:install')
generate('devise', 'user')
generate('cancan:ability')

generate('kaminari:config')
generate('kaminari:views', 'bootstrap -e haml')

generate('bootstrap:install', 'less')
#generate('bootstrap:layout', 'application fixed')
#generate('bootstrap:layout', 'application fluid')
#generate('bootstrap:themed Posts')

generate('simple_form:install', '--bootstrap')
generate('client_side_validations:install')
generate('rspec:install')

append_file 'app/assets/javascripts/application.js', <<-CODE, verbose: false
//= require rails.validations
//= require rails.validations.simple_form
CODE

append_file 'app/assets/stylesheets/application.css', <<-CODE, verbose: false
body {padding-top: 60px;}
CODE

run 'rm app/views/layouts/application.html.erb' # use generated slim version instead
run "rm public/index.html"

environment do
<<-CODE
    config.time_zone = 'Beijing'
    config.i18n.default_locale = 'zh-CN'
    config.generators do |g|
      g.fixture_replacement :factory_girl
    end
CODE
end

template_file 'app/views/common/_menu.html.slim'
template_file 'app/views/common/_search_form.html.slim'
template_file 'app/views/common/_user_nav.html.slim'
template_file 'app/views/layouts/application.html.slim'

#file 'app/views/common/_menu.html.slim', <<-CODE
#.navbar.navbar-fixed-top
  #.navbar-inner
    #.container
      #a.btn.btn-navbar data-target=".nav-collapse" data-toggle="collapse"
        #span.icon-bar
        #span.icon-bar
        #span.icon-bar

      #= render 'common/user_nav'

      #a.brand href="#"Blog
      #= render 'common/search_form'
      #.container.nav-collapse
        #ul.nav
          #li= link_to "Link 1", "/path1"
          #li= link_to "Link 2", "/path2"
          #li= link_to "Link 3", "/path3"
#CODE

#file 'app/views/common/_search_form.html.slim', <<-CODE
#= form_tag '/search', class: 'navbar-search' do
  #= text_field_tag 'q', @q, class: 'input-medium search-query', placeholder: @q || 'Search'
#CODE

#file 'app/views/common/_user_nav.html.slim', <<-CODE
#ul.nav.pills.pull-right
  #- if current_user
    #li.dropdown
      #=link_to '/account', class: 'dropdown-toggle', data: {toggle: 'dropdown'} do
        #= current_user.email
        #span.caret

      #ul.dropdown-menu
        #li= link_to 'Logout', destroy_user_session_path, method: :delete

  #- else
    #li= link_to 'Sign Up', new_user_registration_path
    #li= link_to 'Login', new_user_session_path
#CODE

#file 'app/views/layout/application.html.slim', <<-CODE
#doctype html
#html lang="en"
  #head
    #meta charset="utf-8"
    #meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1"
    #meta name="viewport" content="width=device-width, initial-scale=1.0"
    #title= content_for?(:title) ? yield(:title) : "Blog"
    #= csrf_meta_tags

    #/! Le HTML5 shim, for IE6-8 support of HTML elements
    #/[if lt IE 9]
      #= javascript_include_tag "//cdnjs.cloudflare.com/ajax/libs/html5shiv/3.6.1/html5shiv.js"
    #= stylesheet_link_tag "application", :media => "all"
    #link href="images/apple-touch-icon-144x144.png" rel="apple-touch-icon-precomposed" sizes="144x144"
    #link href="images/apple-touch-icon-114x114.png" rel="apple-touch-icon-precomposed" sizes="114x114"
    #link href="images/apple-touch-icon-72x72.png" rel="apple-touch-icon-precomposed" sizes="72x72"
    #link href="images/apple-touch-icon.png" rel="apple-touch-icon-precomposed"
    #/link href="favicon.ico" rel="shortcut icon"

  #body
    #= render 'common/menu'

    #.container

      #.row
        #.span3
          #.well.sidebar-nav
            #ul.nav.nav-list
              #li.nav-header Sidebar
              #li= link_to "Link 1", "/path1"
              #li= link_to "Link 2", "/path2"
              #li= link_to "Link 3", "/path3"
        #.span9
          #= bootstrap_flash
          #= yield
    
      #footer
        #p &copy; Company 2013
    #/!
      #Javascripts
      #\==================================================
    #/! Placed at the end of the document so the pages load faster
    #= javascript_include_tag "application"
#CODE

generate(:controller, "home index")
route "root :to => 'home#index'"
rake("db:migrate")
 
git :init
git :add => "."
git :commit => "-a -m 'Initial commit'"

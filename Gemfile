source 'https://rubygems.org'
ruby '2.3.1'

gem 'rails'
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder'
gem 'sdoc'
gem 'spring',        group: :development
gem 'bootstrap-sass'
gem 'omniauth'
gem 'omniauth-github'
gem 'simple_form'
gem 'datetimepicker-rails', github: 'zpaulovics/datetimepicker-rails', branch: 'master', submodules: true
gem 'momentjs-rails', '~> 2.9',  :github => 'derekprior/momentjs-rails'
gem 'slim-rails'
gem 'thin'
gem 'twilio-ruby'
gem 'google-api-client'
gem 'omniauth-google-oauth2'
gem 'font-awesome-rails'
gem 'mobvious'
gem 'flutie'
gem 'phony_rails'
gem 'valid_email'

group :development do
  gem 'sqlite3'
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_21]
  gem 'capistrano', '~> 3.1.0'
  gem 'capistrano-bundler', '~> 1.1.2'
  gem 'capistrano-rails', '~> 1.1.1'
  gem 'capistrano-rbenv', github: "capistrano/rbenv"
  gem 'foreman'
  gem 'quiet_assets'
  gem 'rails_layout'
end
group :development, :test do
  gem 'factory_girl_rails'
  gem 'pry-rails'
  gem 'pry-rescue'
  gem 'rspec-rails'
  gem 'dotenv-rails'
end
group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'faker'
  gem 'launchy'
  gem 'selenium-webdriver'
end
group :production do
  gem 'pg'
  gem 'rails_12factor'
end
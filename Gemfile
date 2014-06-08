source 'https://rubygems.org'
ruby "2.0.0"

gem 'sinatra'
gem 'sinatra-activerecord'
gem 'activesupport'
gem 'attr_encrypted'
gem 'rack-flash3', require: 'rack-flash'
gem 'sinatra-twitter-bootstrap', require: 'sinatra/twitter-bootstrap'
gem 'sinatra-redis'
gem 'resque', '~> 1.22.0'
gem 'json'
gem 'foreman'
gem 'rake'
gem 'prawn'
gem 'pony'

gem 'omniauth-shopify-oauth2'
gem 'shopify_api'

group :production do
  gem 'pg'
end

group :development do
  gem 'sqlite3'
  gem 'rack-test'
  gem 'fakeweb'
  gem 'mocha', require: false
  gem 'pry'
  gem 'byebug'
end

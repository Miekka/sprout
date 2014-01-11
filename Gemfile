source 'https://rubygems.org'

ruby '1.9.3'

gem 'rails', '3.2.11'
group :development, :test do
  gem 'sqlite3', '1.3.5'
end
group :production do
  gem 'pg', '0.12.2'
 gem 'thin'
end

group :assets do
  gem 'sass-rails',   '~> 3.2.5'
  gem 'coffee-rails', '~> 3.2.2'
  gem 'uglifier', '>= 1.2.3'
end
gem 'jquery-rails'
gem "rspec-rails", ">= 2.11.4", :group => [:development, :test]
gem "email_spec", ">= 1.2.1", :group => :test
gem "cucumber-rails", ">= 1.3.0", :group => :test, :require => false
gem "database_cleaner", ">= 0.9.1", :group => :test
gem "launchy", ">= 2.1.2", :group => :test
gem "capybara", ">= 1.1.2", :group => :test
gem "factory_girl_rails", ">= 4.1.0", :group => [:development, :test]
gem "bootstrap-sass", ">= 2.1.0.1"
gem "hominid", ">= 3.0.5"
gem "devise", ">= 2.1.2"
gem "cancan", ">= 1.6.8"
gem "rolify", ">= 3.2.0"
gem "simple_form", ">= 2.0.4"
gem "google_visualr", ">= 2.1.2"
gem "jquery-datatables-rails", ">= 1.11.1"
gem "quiet_assets", ">= 1.0.1", :group => :development
gem "heroku"

gem 'rails_12factor'

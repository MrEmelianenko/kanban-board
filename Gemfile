source 'https://rubygems.org'

# Core
gem 'rails', '>= 5.0.0.rc1', '< 5.1'
gem 'pg'
gem 'redis-rails', '~> 5.0.0.pre'
gem 'puma', '~> 3.0'

# Authentication & Authorization
gem 'oauth2', github: 'intridea/oauth2'
gem 'omniauth', github: 'intridea/omniauth'
gem 'omniauth-oauth2', github: 'intridea/omniauth-oauth2'
gem 'omniauth-google-oauth2', github: 'zquestz/omniauth-google-oauth2'
gem 'pundit', '~> 1.1'

# Assets
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks', '~> 5.x'
gem 'bootstrap-sass', '~> 3.3.6'

# Security
gem 'bcrypt', '~> 3.1.7'

# Decorators (My own GEM based on Draper)
# https://github.com/MrEmelianenko/drape/wiki/Meet-Drape!
gem 'drape', '~> 1.0.0.beta1'

# State machine
gem 'aasm', '~> 4.10'

# Other
gem 'figaro', '~> 1.1'
gem 'request_store', '~> 1.3'
gem 'foreman', '~> 0.82.0'
gem 'cocoon', '~> 1.2'

group :development, :test do
  gem 'byebug', platform: :mri
end

group :development do
  # Better Errors pages
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'web-console'

  # Console formatting
  gem 'awesome_print'

  # Cut the rails log
  gem 'quiet_assets'
  gem 'lograge'

  # Spring
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Kanban
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # UUID instead of ID
    config.active_record.primary_key = :uuid

    # Redis Cache Store
    config.cache_store = :redis_store, { namespace: 'cache', expires_in: 90.minutes }

    config.middleware.use OmniAuth::Builder do
      provider :google_oauth2, ENV['GOOGLE_API_KEY'], ENV['GOOGLE_API_SECRET']
    end
  end
end

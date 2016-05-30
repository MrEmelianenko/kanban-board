module LoadSettings
  extend ActiveSupport::Concern

  included do
    # Constants
    SETTINGS_KEY = :settings

    # Callbacks
    before_action :settings

    private

    def settings
      return RequestStore.store[SETTINGS_KEY] if RequestStore.exist?(SETTINGS_KEY)
      RequestStore.store[SETTINGS_KEY] = Hash[Settings.pluck(:key, :value)]
    end
  end
end

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Asagao
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
        # タイムゾーン
        config.time_zone = 'Tokyo'
        # ロケール
        config.i18n.default_locale = :ja
        # ストロングパラメータ無効。公開の時は、有効にしないといけない
        config.action_controller.permit_all_parameters = false
  end
end

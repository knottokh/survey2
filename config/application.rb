require File.expand_path('../boot', __FILE__)

require 'iconv'
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Workspace
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.assets.paths << Rails.root.join("app", "assets", "fonts")

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    #config.active_record.raise_in_transactional_callbacks = true
     config.action_mailer.default_url_options = { :host => 'https://survey2-knottoc9.c9users.io' }
    config.action_mailer.delivery_method = :smtp
    
      config.action_mailer.smtp_settings = {
          :address => "smtp.gmail.com",
          :port => 587,
          :domain => "gmail.com",
          :user_name => "merm.cu@gmail.com",
          :password => "merm11111",
          :authentication => "plain",
          :enable_starttls_auto => true
      }
  end
end
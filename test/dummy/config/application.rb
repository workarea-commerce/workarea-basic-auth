require_relative "boot"

require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"

require "workarea"
Bundler.require(*Rails.groups)
require "workarea/basic_auth"

module Dummy
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end

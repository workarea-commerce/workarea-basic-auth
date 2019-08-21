require "rack"
require "workarea"
require "workarea/admin"
require "workarea/storefront"
require "workarea/basic_auth/engine"
require "workarea/basic_auth/version"

module Workarea
  module BasicAuth
    def self.enabled?
      config.enabled
    end

    def self.config
      Workarea.config.basic_auth
    end
  end
end

require "workarea/basic_auth/path"
require "workarea/basic_auth/simple_route_set"
require "workarea/basic_auth/middleware"
require "workarea/basic_auth/railtie"

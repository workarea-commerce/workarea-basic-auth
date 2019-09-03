require "rack/auth/abstract/handler"
require "rack/auth/abstract/request"

module Workarea
  module BasicAuth
    class Middleware < Rack::Auth::AbstractHandler
      def initialize(app)
        @app = app
        @realm = "workarea-basic-auth"
        @authenticator = Proc.new do |user, pass|
          (Workarea.config.basic_auth.user == user &&
           Workarea.config.basic_auth.pass == pass)
        end
      end

      def call(env)
        return @app.call(env) unless Workarea::BasicAuth.enabled?

        auth = Middleware::Request.new(env)

        return @app.call(env) unless auth.required?
        return unauthorized   unless auth.provided?
        return bad_request    unless auth.basic?
        return unauthorized   unless valid?(auth)

        env["REMOTE_USER"] = auth.username
        @app.call(env)
      end

      private

        def challenge
          'Basic realm="%s"' % realm
        end

        def valid?(auth)
          @authenticator.call(*auth.credentials)
        end

        class Request < Rack::Auth::AbstractRequest
          def required?
            !ip_whitelisted? && path_is_protected?
          end

          def path_is_protected?
            return false if excluded_routes.matches?(request)
            protected_routes.matches?(request)
          end

          def ip_whitelisted?
            whitelisted_ips.any? { |ip| ip.include?(request.ip) }
          end

          def basic?
            "basic" == scheme
          end

          def credentials
            @credentials ||= params.unpack("m*").first.split(/:/, 2)
          end

          def username
            credentials.first
          end

          private

            def protected_routes
              Workarea.config.basic_auth.protect_routes
            end

            def excluded_routes
              Workarea.config.basic_auth.exclude_routes
            end

            def whitelisted_ips
              Array.wrap(Workarea.config.basic_auth.whitelisted_ips)
            end
        end
    end
  end
end

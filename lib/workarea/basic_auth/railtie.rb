module Workarea
  module BasicAuth
    class CredentialsMissing < ArgumentError; end

    class Railtie < Rails::Railtie
      config.to_prepare do
        basic_auth = Workarea.config.basic_auth
        if Workarea::BasicAuth.enabled?
          if basic_auth.user.nil? || basic_auth.pass.nil?
            raise CredentialsMissing, "Basic Auth is enabled but you did not set Workarea.config.basic_auth.user or Workarea.config.basic_auth.password"
          end
        end
      end
    end
  end
end

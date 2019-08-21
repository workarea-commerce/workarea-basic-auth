module Workarea
  module Testing
    module BasicAuthHelper
      def encode_password(username, password)
        Base64.encode64("#{username}:#{password}")
      end

      def build_request(path, method = "GET")
        Rack::Request.new(
          Rack::MockRequest.env_for(path, "REQUEST_METHOD" => method)
        )
      end

      def build_response(path, method = "GET")
        Rack::Response.new(
          Rack::MockRequest.env_for(path, "REQUEST_METHOD" => method)
        )
      end
    end
  end
end

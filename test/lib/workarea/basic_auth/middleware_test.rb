require "test_helper"

module Workarea
  module BasicAuth
    class MiddlewareTest < Workarea::TestCase
      include Workarea::Testing::BasicAuthHelper

      setup :turn_on_basic_auth
      teardown :turn_off_basic_auth

      def middleware
        @middleware ||= BasicAuth::Middleware.new(Rails.application)
      end

      def turn_on_basic_auth
        Workarea.config.basic_auth.enabled = true
        Workarea.config.basic_auth.user = "thomas"
        Workarea.config.basic_auth.pass = "vendetta"
        Workarea.config.basic_auth.protect_routes = BasicAuth::SimpleRouteSet.new
        Workarea.config.basic_auth.exclude_routes = BasicAuth::SimpleRouteSet.new
      end

      def turn_off_basic_auth
        Workarea.config.basic_auth.enabled = false
      end

      def test_unathorized_users_doesnt_do_anything_if_basic_auth_is_disabled
        Workarea.config.basic_auth.enabled = false

        env = Rack::MockRequest.env_for("/")
        response = Rack::Response.new(middleware.call(env))

        assert_equal(200, response.status)
      end

      def test_unathorized_users_returns_200_if_route_is_unprotected
        env = Rack::MockRequest.env_for("/login")
        get_login = Rack::Response.new(middleware.call(env))

        assert_equal(200, get_login.status)
      end

      def test_unauthorized_users_returns_200_if_ip_is_whitelisted
        ip_addr = Workarea.config.basic_auth.whitelisted_ips.first.to_s
        env = Rack::MockRequest.env_for("/login", 'REMOTE_ADDR' => ip_addr)
        get_login = Rack::Response.new(middleware.call(env))

        assert_equal(200, get_login.status)
      end

      def test_unathorized_users_returns_401_for_all_http_methods_on_a_path_by_default
        Workarea.config.basic_auth.protect_routes.add("/login")

        env = Rack::MockRequest.env_for("/login")
        get_login = Rack::MockResponse.new(*middleware.call(env))

        env = Rack::MockRequest.env_for("/login", method: :post)
        post_login = Rack::MockResponse.new(*middleware.call(env))

        env = Rack::MockRequest.env_for("/login", method: :head)
        head_login = Rack::MockResponse.new(*middleware.call(env))

        assert_equal(401, get_login.status)
        assert_equal(401, post_login.status)
        assert_equal(401, head_login.status)
      end

      def test_unathorized_users_returns_401_for_specific_http_methods_on_a_path
        Workarea.config.basic_auth.protect_routes.add("/login", :post)

        env = Rack::MockRequest.env_for("/login")
        get_login = Rack::MockResponse.new(*middleware.call(env))

        env = Rack::MockRequest.env_for("/login", method: :post)
        post_login = Rack::MockResponse.new(*middleware.call(env))

        assert_equal(200, get_login.status)
        assert_equal(401, post_login.status)
      end

      def test_unathorized_users_protects_wildcard_routes
        Workarea.config.basic_auth.protect_routes.add("/*")

        env = Rack::MockRequest.env_for("/login")
        get_login = Rack::MockResponse.new(*middleware.call(env))

        env = Rack::MockRequest.env_for("/login", method: :post)
        post_login = Rack::MockResponse.new(*middleware.call(env))

        env = Rack::MockRequest.env_for("/products/my-product")
        get_product = Rack::MockResponse.new(*middleware.call(env))

        assert_equal(401, get_login.status)
        assert_equal(401, post_login.status)
        assert_equal(401, get_product.status)
      end

      def test_unathorized_users_allows_route_exclusions
        Workarea.config.basic_auth.protect_routes.add("/*")
        Workarea.config.basic_auth.exclude_routes.add("/contact")

        env = Rack::MockRequest.env_for("/login")
        get_login = Rack::MockResponse.new(*middleware.call(env))

        env = Rack::MockRequest.env_for("/contact")
        get_contact = Rack::MockResponse.new(*middleware.call(env))

        assert_equal(401, get_login.status)
        assert_equal(200, get_contact.status)
      end

      def test_unathorized_users_works_properly_with_a_health_check
        Workarea.config.basic_auth.protect_routes.add("/*")
        Workarea.config.basic_auth.exclude_routes.add("/health_check")

        env = Rack::MockRequest.env_for("/health_check")
        health_check = Rack::MockResponse.new(*middleware.call(env))

        assert_equal(200, health_check.status)
      end

      def test_authorized_users_lets_authorized_users_access_all_routes
        Workarea.config.basic_auth.protect_routes.add("/*")

        env = Rack::MockRequest.env_for("/contact")
        bad = Rack::MockResponse.new(*middleware.call(env))
        assert_equal(401, bad.status)

        encoded_pass = encode_password("thomas", "vendetta")
        env_opts = { "HTTP_AUTHORIZATION" => "Basic #{encoded_pass}" }

        env = Rack::MockRequest.env_for("/login", env_opts)
        good = Rack::MockResponse.new(*middleware.call(env))
        assert_equal(200, good.status)
      end

      def test_authorized_users_renders_401_with_invalid_credentials
        Workarea.config.basic_auth.protect_routes.add("/*")

        encoded_pass = encode_password("notavalid", "password")
        env_opts = { "HTTP_AUTHORIZATION" => "Basic #{encoded_pass}" }

        env = Rack::MockRequest.env_for("/contact", env_opts)
        bad = Rack::MockResponse.new(*middleware.call(env))
        assert_equal(401, bad.status)
      end
    end
  end
end

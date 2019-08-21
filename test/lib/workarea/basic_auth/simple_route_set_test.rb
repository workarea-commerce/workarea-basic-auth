require "test_helper"

module Workarea
  module BasicAuth
    class SimpleRouteSetTest < Workarea::TestCase
      include Workarea::Testing::BasicAuthHelper

      def test_add_takes_a_string_and_optional_array_of_http_request_methods
        set = SimpleRouteSet.new
        set.add("/products")
        set.add("/admin", :head)
        set.add("/admin", :head, :post)

        assert_equal(3, set.paths.count)
      end

      def test_matches_requests_based_off_a_proc
        set = SimpleRouteSet.new
        set.add("/login", ->(request) {
          request.env["HTTP_USER_AGENT"] == "CoolAgent"
        })

        bad_request = Rack::Request.new(
          Rack::MockRequest.env_for("/login", "HTTP_USER_AGENT" => "UncoolAgent")
        )

        good_request = Rack::Request.new(
          Rack::MockRequest.env_for("/login", "HTTP_USER_AGENT" => "CoolAgent")
        )

        refute set.matches?(bad_request)
        assert set.matches?(good_request)
      end

      def test_matches_requests_that_are_in_the_set
        set = SimpleRouteSet.new
        set.add("/products")
        set.add("/admin", :options)
        set.add("/admin", :head, :post)

        delete_products = build_request("/products", "DELETE")
        options_admin = build_request("/admin", "OPTIONS")
        post_admin = build_request("/admin", "POST")

        bad = build_request("/admin")

        assert set.matches?(delete_products)
        assert set.matches?(options_admin)
        assert set.matches?(post_admin)

        refute set.matches?(bad)
      end

      def test_does_not_match_requests_not_in_the_set
        set = SimpleRouteSet.new
        set.add("/wat")

        bad = build_request("/bad")

        refute set.matches?(bad)
      end
    end
  end
end

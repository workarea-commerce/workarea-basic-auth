require "test_helper"
require "rack/mock"

module Workarea
  module BasicAuth
    class PathTest < Workarea::TestCase
      include Workarea::Testing::BasicAuthHelper

      def test_matches_a_pathname_and_all_http_methods_by_default
        path = Path.new("/products")

        get = build_request("/products")
        post = build_request("/products", "POST")
        options = build_request("/products", "OPTIONS")
        head = build_request("/products", "HEAD")

        bad = build_request("/wat")

        assert path.matches?(get)
        assert path.matches?(post)
        assert path.matches?(options)
        assert path.matches?(head)

        refute path.matches?(bad)
      end

      def test_matches_a_pathname_and_a_specific_request_method
        path = Path.new("/products", :post, :head)

        get = build_request("/products")
        post = build_request("/products", "POST")
        head = build_request("/products", "HEAD")

        refute path.matches?(get)
        assert path.matches?(post)
        assert path.matches?(head)
      end

      def test_matches_wildcards
        path = Path.new("/api/v2/*")

        good = build_request("/api/v2/wat/sup")
        bad = build_request("/api/v1/wat/sup")

        assert path.matches?(good)
        refute path.matches?(bad)
      end
    end
  end
end

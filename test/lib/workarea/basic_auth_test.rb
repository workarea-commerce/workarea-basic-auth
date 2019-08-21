require "test_helper"

module Workarea
  class BasicAuthTest < Workarea::TestCase
    def test_creates_workarea_config_basic_auth_with_route_sets
      basic_auth = Workarea.config.basic_auth
      refute_nil(basic_auth)
      assert_instance_of(BasicAuth::SimpleRouteSet, basic_auth.protect_routes)
      assert_instance_of(BasicAuth::SimpleRouteSet, basic_auth.exclude_routes)
    end
  end
end

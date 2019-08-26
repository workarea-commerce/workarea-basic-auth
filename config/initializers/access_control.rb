Workarea.configure do |config|
  basic_auth = ActiveSupport::Configurable::Configuration.new
  basic_auth.enabled = false

  basic_auth.protect_routes = Workarea::BasicAuth::SimpleRouteSet.new
  basic_auth.exclude_routes = Workarea::BasicAuth::SimpleRouteSet.new

  basic_auth.exclude_routes.add("/*", ->(request) {
    request.env["HTTP_USER_AGENT"].to_s.include?("ELB-HealthChecker")
  })

  basic_auth.protect_routes.add("/*")
  basic_auth.exclude_routes.add("/api*")
  basic_auth.exclude_routes.add("/assets/*")
  basic_auth.exclude_routes.add("/media/*")
  basic_auth.exclude_routes.add("/product_images/*")

  if Rack::Attack.const_defined? :IGNORED_IP_ADDRESSES
    basic_auth.whitelisted_ips = Rack::Attack::IGNORED_IP_ADDRESSES
  end

  Workarea.config.basic_auth = basic_auth

  Rails.application.config.middleware.insert_before 0, Workarea::BasicAuth::Middleware
end

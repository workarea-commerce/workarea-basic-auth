$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "workarea/basic_auth/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "workarea-basic_auth"
  s.version     = Workarea::BasicAuth::VERSION
  s.authors     = ["Thomas Vendetta"]
  s.email       = ["tvendetta@workarea.com"]
  s.homepage    = "https://github.com/workarea-commerce/workarea-basic-auth"
  s.summary     = "HTTP basic authentication Rack middleware for the Workarea Commerce Platform"
  s.description = "HTTP basic authentication Rack middleware for the Workarea Commerce Platform"
  s.files       = `git ls-files`.split("\n")
  s.license = 'Business Software License'
  s.test_files  = Dir["test/**/*"]

  s.required_ruby_version = ">= 2.0.0"

  s.add_dependency "workarea", "~> 3.x", ">= 3.0.4"
  s.add_dependency "rack",     "~> 2.0"

  s.post_install_message = <<~MSG
    Workarea Basic Auth is installed. Add the following configuration to
    an initializer or to an environment.rb file to enable:

        Workarea.configure do |config|
          config.basic_auth.enabled = true
          config.basic_auth.user = 'my_username'
          config.basic_auth.pass = 'my_password'
          config.basic_auth.protect_routes.add('/*')
          config.basic_auth.exclude_routes.add('/api*')
        end

    For more information check out the README:
    https://github.com/workarea-commerce/workarea-basic-auth
  MSG
end

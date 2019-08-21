Workarea Basic Auth
================================================================================

A Workarea Commerce plugin that adds middleware to enable HTTP Basic Auth for the Workarea Commerce platform, preventing undesired traffic (like bots) on staging and QA environments.

Getting Started
--------------------------------------------------------------------------------

Add the gem to your application's Gemfile:

```ruby
# ...
gem 'workarea-basic_auth'
# ...
```

Update your application's bundle.

```bash
cd path/to/application
bundle
```

Configuration
--------------------------------------------------------------------------------

By default, `workarea-basic-auth` is disabled. To require basic authentication for routes in your application, set the following properties in `Workarea.config`:

```ruby
Workarea.configure do |config|
  config.basic_auth.enabled = true
  config.basic_auth.user = 'my_username'
  config.basic_auth.pass = 'my_password'
  config.basic_auth.protect_routes.add('/products')
  config.basic_auth.protect_routes.add('/categories')
  config.basic_auth.protect_routes.add('/contact')
  config.basic_auth.exclude_routes.add('/api*')
  config.basic_auth.exclude_routes.add('/products/my-sweet-product')
end
```

The configuration above will require HTTP basic auth for all routes and HTTP methods other than those that start with `/api` or `/products/my-sweet-product`.

### Excluding Assets

Need to exclude assets from http basic auth?

```ruby
Workarea.configure do |config|
  config.basic_auth.enabled = true
  config.basic_auth.user = 'my_username'
  config.basic_auth.pass = 'my_password'
  config.basic_auth.exclude_routes.add('/assets/*')
end
```


### Excluding routes based off HTTP method

You can also specify protecting or excluding protection of routes for specific
HTTP methods:

```ruby
Workarea.configure do |config|
  config.basic_auth.enabled = true
  config.basic_auth.user = 'my_username'
  config.basic_auth.pass = 'my_password'
  config.basic_auth.protect_routes.add('/login', :post, :option)
  config.basic_auth.protect_routes.add('/contact', :put)
end
```

The configuration above will require HTTP basic auth when sending a
`POST` or `OPTION` request to `/login` or a `PUT` request to `/contact`.

### Excluding routes based off a Proc

Sometimes you may run into a case where path/method just won't cut it. You can
pass a protect or exclude route a proc that will be passed a Rack::Request object.
Anytime the proc returns true, that path will match for either protection or exclusion.

For example, in order to allow the AWS ElasticLoadBalancer the ability to check
an instances health, we exclude basic auth protection from any request where the
User Agent contains 'ELB-HealthChecker':

```ruby
Workarea.configure do |config|
  config.basic_auth.enabled = true
  config.basic_auth.user = 'my_username'
  config.basic_auth.pass = 'my_password'
  config.basic_auth.exclude_routes.add('/*', ->(request) {
    request.env['HTTP_USER_AGENT'].include?('ELB-HealthChecker')
  })
end
```

Workarea Commerce Documentation
--------------------------------------------------------------------------------

See [https://developer.workarea.com](https://developer.workarea.com) for Workarea Commerce documentation.

License
--------------------------------------------------------------------------------

Workarea Basic Auth is released under the [Business Software License](LICENSE)

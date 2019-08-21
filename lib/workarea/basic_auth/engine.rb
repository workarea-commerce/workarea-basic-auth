module Workarea
  module BasicAuth
    class Engine < ::Rails::Engine
      include Workarea::Plugin
      isolate_namespace Workarea::BasicAuth
    end
  end
end

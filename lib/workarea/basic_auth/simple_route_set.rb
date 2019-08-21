module Workarea
  module BasicAuth
    class SimpleRouteSet
      attr_reader :paths

      def initialize
        @paths = []
      end

      def add(path_string, *http_methods)
        paths.push(Path.new(path_string, *http_methods))
      end

      def remove(path_string)
        @paths = paths.reject { |path| path.matches?(path_string) }
      end

      def matches?(request)
        paths.detect { |path| path.matches?(request) }.present?
      end
    end
  end
end

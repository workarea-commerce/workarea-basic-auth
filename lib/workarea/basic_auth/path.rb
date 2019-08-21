module Workarea
  module BasicAuth
    class Path
      attr_reader :regexp

      def initialize(string, *http_methods)
        path = Regexp.escape(string).gsub('\*', ".*?")
        @regexp = Regexp.new("^#{path}$", true)

        if http_methods && http_methods.first.is_a?(Proc)
          @proc = http_methods.first
        end

        @http_methods = http_methods
      end

      def matches?(request)
        path_matches?(request) && request_matches?(request)
      end

      private

        def path_matches?(request)
          !@regexp.match(request.path_info).nil?
        end

        def request_matches?(request)
          if @proc
            @proc.call(request)
          else
            method = request.env["REQUEST_METHOD"].downcase.to_sym
            @http_methods.empty? || @http_methods.include?(method)
          end
        end
    end
  end
end

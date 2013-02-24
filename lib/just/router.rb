module Just
  module Router

    def string_routes
      @string_routes ||= {}
    end

    def regex_routes
      @regex_routes ||= {}
    end

    def store_route(pattern, &block)
      if pattern.is_a?(String)
        string_routes[pattern] = lambda { block.call }
      elsif pattern.is_a?(Regexp)
        regex_routes[pattern] = lambda { |matches| block.call(matches) }
      end
    end

    def route(path)
      if string_routes[path]
        string_routes[path].call
      else
        pattern, route = regex_routes.find { |key, route| key.match(path) }
        return route.call(pattern.match(path)) if route
      end
    end

    def get(pattern, &block)
      if block_given?
        store_route(pattern, &block)
      else
        route(pattern)
      end
    end
  end
end
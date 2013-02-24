module Just
  module Router

    def string_routes
      @string_routes ||= {}
    end

    def regex_routes
      @regex_routes ||= []
    end

    def store_route(pattern, &block)
      if pattern.is_a?(String)
        string_routes[pattern] = lambda { block.call }
      end
    end

    def route(pattern)
      if string_routes[pattern]
        string_routes[pattern].call
      else
        match = regex_routes.find { |route| route.match(pattern) }
        return match.call if match
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
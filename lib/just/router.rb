module Just
  module Router
    def string_routes
      @string_routes ||= {}
    end

    def regex_routes
      @regex_routes ||= {}
    end

    def store_route(http_method, pattern, &block)
      if pattern.is_a?(String)
        (string_routes[http_method]||={})[pattern] = lambda { |params| block.call(params) }
      elsif pattern.is_a?(Regexp)
        (regex_routes[http_method] ||= {})[pattern] = lambda { |matches| block.call(matches) }
      end
    end

    Just::HTTP_VERBS.each do |http_method|
      define_method http_method, ->(pattern, params = {}, &block) { store_route(http_method, pattern, &block)}
    end
  end
end
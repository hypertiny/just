module Just
  module Application
    def router(router_class = ::Router)
      @router ||= router_class
    end

    def route(http_method, path, params = {})
      raise "No route matched" if router.string_routes[http_method].nil?
      if router.string_routes[http_method][path]
        router.string_routes[http_method][path].call(params)
      else
        pattern, route = router.regex_routes[http_method].find { |key, route| key.match(path) }
        return route.call(pattern.match(path)) if route
      end
    end

    [:get, :post].each do |http_method|
      define_method http_method do |path, params = {}|
        route(http_method, path, params)
      end
    end
  end
end
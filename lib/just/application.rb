module Just
  module Application
    def router(router_class = ::Router)
      @router ||= router_class
    end

    def merge_params_and_matches(http_params, matches)
      route_params = matches ? Hash[ matches.names.zip( matches.captures ) ] : {}
      (http_params ||= {}).merge(route_params)
    end

    def route(http_method, path, http_params = {})
      route, params = if (router.string_routes[http_method] ||= {})[path]
        [router.string_routes[http_method][path], http_params]
      else
        pattern, route = router.regex_routes[http_method].find { |key, route| key.match(path) }
        [route, merge_params_and_matches(http_params, pattern.match(path))]
      end
      raise "No route matched #{http_method.upcase} #{path}" if route.nil?
      route.call(params) if route
    end

    Just::HTTP_VERBS.each do |http_method|
      define_method http_method do |path, http_params = {}|
        route(http_method, path, http_params)
      end
    end
  end
end
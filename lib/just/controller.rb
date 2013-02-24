require 'active_support/hash_with_indifferent_access'
module Just
  module Controller

    def initialize(attrs = {})
      @route_params = attrs[:route_params] ? Hash[ attrs[:route_params].names.zip( attrs[:route_params].captures ) ] : {}
      @http_params = attrs[:params] || {}
    end

    def params
      HashWithIndifferentAccess[@route_params.merge(@http_params)]
    end

  end
end
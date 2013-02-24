module Just
  module Controller
    attr_accessor :params

    def initialize(attrs = {})
      @params = attrs[:route_params]
    end

  end
end
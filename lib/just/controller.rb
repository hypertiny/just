require 'active_support/hash_with_indifferent_access'
module Just
  module Controller

    def initialize(attrs = {})
      @params = attrs[:params]
    end

    def params
      HashWithIndifferentAccess[@params]
    end

  end
end
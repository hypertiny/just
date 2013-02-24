module Just
  HTTP_VERBS = [:options, :get, :head, :post, :put, :delete, :patch]
end

require 'just/version'
require 'just/application'
require 'just/controller'
require 'just/router'
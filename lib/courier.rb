require "courier/version"

module Courier
  module Middleware
    autoload :ShopifyOAuth, 'courier/middleware/shopify_oauth'
    autoload :DebugRequest, 'courier/middleware/debug_request'
  end

  autoload :Session, 'courier/session'
end

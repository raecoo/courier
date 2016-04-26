require 'faraday'
require 'faraday_middleware'
require 'faraday/request'

module Courier
  class Session
    class << self
      def connection(domain, token: nil, api_key: nil, password: nil, debug: false)
        fail ArgumentError, "Require token or (api_key and password)" unless token || (api_key && password)
        Faraday.new("https://#{domain}/admin") do |f|
          if token
            f.request :shopify_oauth, token
          else
            f.request :basic_auth, api_key, password
          end

          f.request  :json
          f.request  :debug if debug
          f.response :json
          f.adapter Faraday.default_adapter
        end
      end
    end
  end
end

if Faraday::Middleware.respond_to? :register_middleware
  puts 'registering'
  Faraday::Request.register_middleware \
    shopify_oauth: -> { Courier::Middleware::ShopifyOAuth },
    debug:         -> { Courier::Middleware::DebugRequest }
end

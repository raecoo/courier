require 'faraday/middleware'

module Courier
  module Middleware
    class ShopifyOAuth < Faraday::Middleware
      # https://docs.shopify.com/api/authentication/oauth#making-authenticated-requests
      # https://github.com/Shopify/shopify_api/blob/master/lib/shopify_api/session.rb#L25
      AUTH_HEADER = 'X-Shopify-Access-Token'.freeze
      attr_reader :token

      def call(env)
        env[:request_headers][AUTH_HEADER] = token
        @app.call env
      end

      def initialize(app, token)
        @app   = app
        @token = token.to_s
      end
    end
  end
end

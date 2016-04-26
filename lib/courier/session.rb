require 'faraday'
require 'faraday_middleware'
require 'faraday/request'
require "recursive-open-struct"

module Courier
  class Session
    attr_accessor :conn

    def initialize(domain, token: nil, api_key: nil, password: nil, debug: false)
      fail ArgumentError, "Require token or (api_key and password)" unless token || (api_key && password)
      @conn = Faraday.new("https://#{domain}/admin") do |f|
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

    def find(resources, id: nil, params: {})
      resources = resources.to_s
      endpoint = id ? "#{resources}/#{id}.json" : "#{resources}.json"
      response = conn.get(endpoint, params)
      data = []
      if response.status == 200
        data =  if id
          RecursiveOpenStruct.new(response.body["#{resources.singularize}"])
        else
          response.body["#{resources}"].map {|r| RecursiveOpenStruct.new(r) }
        end
      end
      return data
    end

    def update(resources, id, params = {})
      resources = resources.to_s
      response = conn.put("#{resources}/#{id}.json", {"#{resources.singularize}": params})
      data = nil
      if response.status == 200
        data = RecursiveOpenStruct.new(response.body["#{resources.singularize}"])
      end
      return data
    end

  end
end

if Faraday::Middleware.respond_to? :register_middleware
  puts 'registering'
  Faraday::Request.register_middleware \
    shopify_oauth: -> { Courier::Middleware::ShopifyOAuth },
    debug:         -> { Courier::Middleware::DebugRequest }
end

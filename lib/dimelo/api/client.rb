module Dimelo
  module API
    
    class Error < Exception
      attr_accessor :original_exception
    end
    
    class Client
      
      attr_accessor :base_uri, :default_parameters
      
      def initialize(base_uri, default_parameters={})
        @base_uri = base_uri.is_a?(URI) ? base_uri : URI.parse(base_uri)
        @default_parameters = default_parameters
      end
      
      def transport(method, path, params={})
        response = connection.perform(request(method, path, params))
        response.value
        response.body
      rescue Net::HTTPExceptions => e
        raise Error.new(response.body).tap{ |exc| exc.original_exception = e }
      end
      
      def request(method, path, params)
        request_class = Net::HTTP.const_get(method.to_s.camelize)
        request_class.new(request_uri(path, params)).tap do |request|
          request.body = request_body(params[:body])
        end
      end
      
      private
      
      def request_uri(path, params)
        @base_uri.dup.tap do |uri|
          uri.path = File.join(uri.path, path).chomp('/')
          uri.query = @default_parameters.merge((params[:query] || {})).to_query
        end.request_uri
      end
      
      def request_body(body)
        body.is_a?(Hash) ? body.to_query : body.to_s
      end
      
      def connection
        @connection ||= Connection.from_uri(@base_uri)
      end
      
    end
  end
end
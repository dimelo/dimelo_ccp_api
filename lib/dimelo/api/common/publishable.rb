module Dimelo
  module Api
    module Common
      module Publishable

        def publish
          path = "#{compute_path(attributes)}/publish"
          response = client.transport(:put, path)
          self.attributes = Dimelo::API.decode_json(response)
          errors.empty?
        end

        def unpublish
          path = "#{compute_path(attributes)}/unpublish"
          response = client.transport(:put, path)
          self.attributes = Dimelo::API.decode_json(response)
          errors.empty?
        end

      end
    end
  end
end
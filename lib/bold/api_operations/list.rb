module Bold
  module APIOperations
    module List
      def list
        HTTParty.get(API_URL + resource_path, headers: headers)
      end

      private

      def headers
        {"api-key" => Bold.api_key}
      end
    end
  end
end

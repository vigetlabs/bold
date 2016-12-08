module Bold
  module APIOperations
    module Create
      def create(params)
        resource_from post(Bold.api_url + resource_path, body: params)
      end
    end
  end
end

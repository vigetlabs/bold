module Bold
  module APIOperations
    module Create
      def create(params)
        resource_from post(resource_path, body: params)
      end
    end
  end
end

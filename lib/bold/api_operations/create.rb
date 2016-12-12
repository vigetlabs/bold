module Bold
  module APIOperations
    module Create
      def create(params)
        resource_from post(create_path, body: params)
      end

      private

      def create_path
        resource_path
      end
    end
  end
end

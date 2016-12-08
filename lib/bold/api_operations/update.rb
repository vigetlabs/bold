module Bold
  module APIOperations
    module Update
      def update(id, params)
        resource_from put(resource_path(id), body: params)
      end
    end
  end
end

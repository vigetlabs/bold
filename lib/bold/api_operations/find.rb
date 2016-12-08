module Bold
  module APIOperations
    module Find
      def find(id)
        resource_from get(resource_path(id))
      end
    end
  end
end

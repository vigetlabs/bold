module Bold
  module APIOperations
    module List
      def list(path = nil)
        resources_from get(path || resource_path)
      end
    end
  end
end

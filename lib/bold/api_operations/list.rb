module Bold
  module APIOperations
    module List
      def list
        resources_from get(Bold.api_url + resource_path)
      end
    end
  end
end

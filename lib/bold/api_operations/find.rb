module Bold
  module APIOperations
    module Find
      def find(id)
        resource_from get(Bold.api_url + resource_path + "/#{id}")
      end
    end
  end
end

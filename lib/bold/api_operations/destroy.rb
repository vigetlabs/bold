module Bold
  module APIOperations
    module Destroy
      def destroy(id)
        resource_from delete(resource_path(id))
      end
    end
  end
end

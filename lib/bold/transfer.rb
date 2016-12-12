module Bold
  class Transfer < APIResource
    def self.display_keys
      ["id", "status", "source_amount"]
    end

    private

    def self.create_path
      resource_path + "/send"
    end
  end
end

module Bold
  class Transfer < APIResource
    def self.display_keys
      ["id", "status", "source_amount"]
    end
  end
end

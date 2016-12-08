module Bold
  class Recipient < APIResource
    def self.display_keys
      ["id", "remote_id", "email"]
    end
  end
end

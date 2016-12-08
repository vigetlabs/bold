module Bold
  class Wallet < APIResource
    def self.display_keys
      ["id", "name", "last4"]
    end

    def self.for_recipient(recipient_id)
      list(Recipient.resource_path(recipient_id) + self.resource_path)
    end
  end
end

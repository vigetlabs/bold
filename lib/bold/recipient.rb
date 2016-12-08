module Bold
  class Recipient < APIResource
    def self.display_keys
      ["id", "remote_id", "email"]
    end

    def wallets
      Wallet.for_recipient(id)
    end
  end
end

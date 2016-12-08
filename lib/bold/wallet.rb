module Bold
  class Wallet < APIResource
    def self.display_keys
      ["id", "name", "last4"]
    end
  end
end

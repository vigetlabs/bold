module Bold
  class APIResource
    def self.class_name
      self.name.split("::").last
    end

    def self.resource_path
      if self == APIResource
        raise NotImplementedError.new('APIResource is an abstract class.  You should perform actions on its subclasses (Recipient, Wallet, etc.)')
      end
      "/v1/#{class_name.downcase}s"
    end
  end
end

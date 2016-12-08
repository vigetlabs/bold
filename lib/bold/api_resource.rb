module Bold
  class APIResource
    extend Errors
    extend APIOperations::Create
    extend APIOperations::Destroy
    extend APIOperations::Find
    extend APIOperations::List
    extend APIOperations::Update

    class << self
      def display_keys
        []
      end

      def resource_path(id = nil)
        if self == APIResource
          raise NotImplementedError.new('APIResource is an abstract class.  You should perform actions on its subclasses (Recipient, Wallet, etc.)')
        end

        id ? "/#{class_name.downcase}s/#{id}" : "/#{class_name.downcase}s"
      end

      private

      def resources_from(response)
        data = JSON.parse(response.body)
        raise InvalidResponse unless data["data"].is_a? Array

        data["data"].map do |data|
          new(data)
        end
      end

      def resource_from(response)
        data = JSON.parse(response.body)
        new(data["data"])
      end

      [:post, :put, :get, :delete].each do |action|
        define_method(action) do |path, opts = {}|
          api_call { HTTParty.send(action, Bold.api_url + path, opts.merge(headers: headers)) }
        end
      end

      def api_call
        yield.tap do |response|
          handle_error(response) if response.code != 200
        end
      end

      def class_name
        self.name.split("::").last
      end

      def headers
        {"api-key" => Bold.api_key}
      end
    end

    def initialize(data)
      raise InvalidResponse unless data.is_a? Hash

      data.keys.each do |key|
        if self.class.display_keys.include? key.to_s
          # set these solely for presentation purposes
          # when interacting with resources in a repl
          instance_variable_set("@#{key}", data[key])
        end

        define_singleton_method key do
          data[key]
        end
      end
    end
  end
end

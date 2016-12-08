module Bold
  class APIResource
    extend Errors
    extend APIOperations::List
    extend APIOperations::Create
    extend APIOperations::Find

    class << self
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

      def post(url, opts = {})
        api_call { HTTParty.post(url, opts.merge(headers: headers)) }
      end

      def get(url, opts = {})
        api_call { HTTParty.get(url, opts.merge(headers: headers)) }
      end

      def api_call
        yield.tap do |response|
          handle_error(response) if response.code != 200
        end
      end

      def resource_path
        if self == APIResource
          raise NotImplementedError.new('APIResource is an abstract class.  You should perform actions on its subclasses (Recipient, Wallet, etc.)')
        end
        "/v1/#{class_name.downcase}s"
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
        if ["id", "remote_id", "email"].include? key.to_s
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

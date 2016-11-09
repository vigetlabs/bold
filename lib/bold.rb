require "httparty"
require "bold/version"

# API Operations
require "bold/api_operations/list"

# Resources
require "bold/api_resource"
require "bold/recipient"

module Bold
  API_URL = "https://api.gobold.com"

  class << self
    attr_accessor :api_key
  end
end

require "httparty"
require "bold/version"

# Errors
require "bold/errors"

# API Operations
require "bold/api_operations/list"
require "bold/api_operations/create"
require "bold/api_operations/find"

# Resources
require "bold/api_resource"
require "bold/recipient"
require "bold/transfer"
require "bold/wallet"

module Bold
  class << self
    attr_accessor :api_key
    attr_accessor :api_url
  end
end

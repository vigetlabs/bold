module Bold
  class InvalidResponse     < StandardError; end
  class BadRequest          < StandardError; end
  class Unauthorized        < StandardError; end
  class Forbidden           < StandardError; end
  class NotFound            < StandardError; end
  class UnprocessableEntity < StandardError; end
  class TooManyRequests     < StandardError; end
  class ApiError            < StandardError; end

  module Errors
    private

    def handle_error(response)
      raise error_class(response).new error_message(response)
    end

    def error_class(response)
      {
        400 => BadRequest,
        401 => Unauthorized,
        403 => Forbidden,
        404 => NotFound,
        422 => UnprocessableEntity,
        429 => TooManyRequests
      }[response.code] || ApiError
    end

    def error_message(response)
      response.parsed_response["error"]["message"]
    end
  end
end

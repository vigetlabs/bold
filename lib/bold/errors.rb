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
      raise error_class(response).new(response)
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
  end
end

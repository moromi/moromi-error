module Moromi
  module Error
    module Rescue
      extend ActiveSupport::Concern

      included do
        # 5xx error
        rescue_from Moromi::Error::Default, with: -> (e) { render_internal_server_error(exception: e) }

        # 4xx error
        rescue_from Moromi::Error::ValidationError, with: -> (e) { render_bad_request(exception: e) }
        rescue_from Moromi::Error::AuthenticationFailed, with: -> (e) { render_unauthorized(exception: e) }
        rescue_from Moromi::Error::PermissionDenied, with: -> (e) { render_forbidden(exception: e) }
        rescue_from Moromi::Error::NotFound, with: -> (e) { render_not_found(exception: e) }
        rescue_from Moromi::Error::TooManyRequests, with: -> (e) { render_too_many_requests(exception: e) }
        rescue_from Moromi::Error::NeedForceUpdate, with: -> (e) { render_force_update(exception: e) }
      end
    end
  end
end

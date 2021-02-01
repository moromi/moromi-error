class ErrorsController < ApplicationController
  include Moromi::Error::Renderer
  include Moromi::Error::Rescue

  def default_error
    raise Moromi::Error::Default
  end

  def validation_error
    raise Moromi::Error::ValidationError
  end

  def not_found
    raise Moromi::Error::NotFound
  end

  def permission_denied
    raise Moromi::Error::PermissionDenied
  end

  def authentication_failed
    raise Moromi::Error::AuthenticationFailed
  end

  def need_force_update
    e = Moromi::Error::NeedForceUpdate.new
    e.detail_url = 'https://example.com'
    raise e
  end

  def too_many_requests
    raise Moromi::Error::TooManyRequests
  end
end

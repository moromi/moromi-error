# frozen_string_literal: true
module Moromi::Error
  module Renderer
    extend ActiveSupport::Concern

    ERROR_TEMPLATES = {
      default: 'moromi/error/default',
    }.freeze

    included do
      class_attribute :default_moromi_error_template_path
      class_attribute :default_moromi_error_renderer_options
      class_attribute :moromi_error_logger

      self.default_moromi_error_template_path = ERROR_TEMPLATES[:default]
      self.default_moromi_error_renderer_options = {layout: false}
      self.moromi_error_logger = Moromi::Error::DefaultLogger.new
    end

    def render_bad_request(exception: Moromi::Error::Default.new, options: nil, locals: {})
      render_error(400, 'Bad Request', exception, options: options, locals: locals)
    end

    def render_unauthorized(exception: Moromi::Error::Default.new, options: nil, locals: {})
      render_error(401, 'Unauthorized', exception, options: options, locals: locals)
    end

    def render_forbidden(exception: Moromi::Error::Default.new, options: nil, locals: {})
      render_error(403, 'Forbidden', exception, options: options, locals: locals)
    end

    def render_not_found(exception: Moromi::Error::Default.new, options: nil, locals: {})
      render_error(404, 'Not Found', exception, options: options, locals: locals)
    end

    def render_conflict(exception: Moromi::Error::Default.new, options: nil, locals: {})
      render_error(409, 'Conflict', exception, options: options, locals: locals)
    end

    def render_gone(exception: Moromi::Error::Default.new, options: nil, locals: {})
      render_error(410, 'Gone', exception, options: options, locals: locals)
    end

    def render_too_many_requests(exception: Moromi::Error::Default.new, options: nil, locals: {})
      render_error(429, 'Too Many Requests', exception, options: options, locals: locals)
    end

    def render_force_update(exception: Moromi::Error::NeedForceUpdate.new, options: nil, locals: {})
      render_bad_request(exception: exception, options: options, locals: locals)
    end

    def render_internal_server_error(exception: Moromi::Error::Default.new, options: nil, locals: {})
      render_error(500, 'Internal Server Error', exception, options: options, locals: locals)
    end

    def render_service_unavailable(exception: Moromi::Error::Default.new, options: nil, locals: {})
      render_error(503, 'Service Unavailable', exception, options: options, locals: locals)
    end

    private

    def render_error(status, title, exception, options: nil, template_path: nil, locals: {})
      template_path ||= self.class::default_moromi_error_template_path
      options = options || self.class::default_moromi_error_renderer_options
      e = Moromi::Error::Default.make(exception)

      self.class::moromi_error_logger.write(self, status, title, exception, options, locals)

      options = {status: status}.merge(options)
      locals = {status: status, title: title, exception: e}.merge(locals)

      render_block = -> {
        render template_path, **options, locals: locals
      }

      respond_to do |format|
        format.html &render_block
        format.json &render_block
      end
    rescue ActionController::UnknownFormat
      render status: 406, body: "Not Acceptable"
    end
  end
end

# frozen_string_literal: true
module Moromi::Error
  module Renderer
    extend ActiveSupport::Concern

    ERROR_TEMPLATES = {
      default: 'moromi/error/default',
      force_update: 'moromi/error/force_update'
    }.freeze

    included do
      class_attribute :default_moromi_error_renderer_options
      class_attribute :moromi_error_logger

      self.default_moromi_error_renderer_options = {partial: ERROR_TEMPLATES[:default], layout: false}
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

    def render_force_update(exception: Moromi::Error::NeedForceUpdate.new, options: nil, locals: {})
      options = options || {partial: ERROR_TEMPLATES[:force_update], layout: false}
      render_bad_request(exception: exception, options: options, locals: locals)
    end

    private

    def render_error(status, title, exception, options: nil, locals: {})
      options = options || self.class::default_moromi_error_renderer_options
      e = Moromi::Error::Default.make(exception)

      self.class::moromi_error_logger.write(status, title, exception, options, locals)

      options = {status: status}.merge(options)
      locals = {status: status, title: title, exception: e}.merge(locals)

      render_block = -> {
        render options.merge({locals: locals})
      }

      respond_to do |format|
        format.html &render_block
        format.json &render_block
      end
    end
  end
end

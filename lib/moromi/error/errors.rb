# frozen_string_literal: true
module Moromi::Error
  class Default < StandardError
    DEFAULT_CODE = 0
    DEFAULT_TITLE = 'moromi-error.an_error_has_occurred'
    DEFAULT_ERRORS = ['moromi-error.an_error_has_occurred']

    attr_reader :code
    attr_reader :title
    attr_reader :errors

    # @param [Integer] code
    # @param [String] title
    # @param [Array<String>] errors
    # @param [String] message
    # @param [String] debug_message
    def initialize(code: nil, title: nil, errors: self.class::DEFAULT_ERRORS, message: nil, debug_message: nil)
      super(message)
      @code = code || self.class::DEFAULT_CODE
      @title = translate(title || self.class::DEFAULT_TITLE)
      @errors = Array(errors).map { |error| translate(error) }
      @debug_message = debug_message if Moromi::Error.config.debug
    end

    # @return [String]
    def debug_message
      return '' unless Moromi::Error.config.debug
      @debug_message || try(:backtrace).try(:first) || ''
    end

    # @param [Exception] exception
    # @return [Moromi::Error::Default]
    def self.make(exception)
      return exception if exception.is_a? Default
      new(debug_message: exception.message)
    end

    private

    # @param [String] key
    # @return [String]
    def translate(key)
      I18n.translate(key, scope: [:strings], default: key.to_s)
    end
  end

  class ValidationError < Default
    DEFAULT_CODE = 10000
    DEFAULT_ERRORS = ['moromi-error.validation_error']

    # @param [Exception] exception
    # @return [Moromi::Error::Default]
    def self.make(exception)
      if defined?(ActiveRecord::RecordInvalid) && exception.is_a?(ActiveRecord::RecordInvalid)
        return new(debug_message: exception.try(:backtrace), message: exception.message, errors: [exception.message])
      end

      if defined?(WeakParameters::ValidationError) && exception.is_a?(WeakParameters::ValidationError)
        return new(debug_message: exception.message, message: exception.message)
      end

      super(exception)
    end
  end

  class NotFound < Default
    DEFAULT_CODE = 10001
    DEFAULT_ERRORS = ['moromi-error.not_found']
  end

  class PermissionDenied < Default
    DEFAULT_CODE = 10002
    DEFAULT_ERRORS = ['moromi-error.permission_denied']
  end

  class AuthenticationFailed < Default
    DEFAULT_CODE = 10003
    DEFAULT_ERRORS = ['moromi-error.authentication_failed']
  end

  class NeedForceUpdate < Default
    DEFAULT_CODE = 10004
    DEFAULT_ERRORS = ['moromi-error.need_force_update']

    attr_accessor :store_url
  end
end

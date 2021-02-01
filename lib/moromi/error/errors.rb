# frozen_string_literal: true
module Moromi::Error
  class Default < StandardError
    DEFAULT_CODE = 0
    DEFAULT_TITLE = 'moromi-error.an_error_has_occurred'
    DEFAULT_ERRORS = ['moromi-error.an_error_has_occurred']

    attr_reader :errors
    attr_reader :debug_message
    attr_reader :log_severity
    attr_accessor :original_exception
    attr_accessor :detail_url

    # @param [Integer] code
    # @param [String] error_title
    # @param [Array<String>] errors
    # @param [String] message
    # @param [String] debug_message
    # @param [String] detail_url
    # @param [Boolean] skip_logging
    # @param [Integer] log_severity
    def initialize(code: nil, error_title: nil, errors: self.class::DEFAULT_ERRORS, message: nil, debug_message: nil, detail_url: nil, skip_logging: false, log_severity: Logger::Severity::ERROR)
      super(message)
      @code = code
      @error_title = error_title
      @errors = errors
      @debug_message = debug_message if Moromi::Error.config.debug
      @detail_url = detail_url
      @skip_logging = skip_logging
      @log_severity = log_severity
    end

    # @param [Exception] exception
    # @return [Moromi::Error::Default]
    def self.make(exception)
      return exception if exception.is_a? ::Moromi::Error::Default

      new(debug_message: exception.try(:message) || '').tap do |e|
        e.original_exception = exception
      end
    end

    def code
      @code || self.class::DEFAULT_CODE
    end

    def errors
      Array(@errors).map(&method(:translate))
    end

    def error_title
      translate(@error_title || self.class::DEFAULT_TITLE)
    end

    # @return [String]
    def debug_message
      return '' unless Moromi::Error.config.debug

      @debug_message || cleaned_backtrace.first || ''
    end

    def skip_logging?
      @skip_logging
    end

    def cleaned_backtrace
      ::Rails.backtrace_cleaner.clean(backtrace || [])
    end

    private

    # @param [String] key
    # @return [String]
    def translate(key)
      I18n.t(key, scope: [:strings], default: key.to_s) % translate_params
    end

    def translate_params
      {error_code: code}
    end
  end

  class ValidationError < Default
    DEFAULT_CODE = 10000
    DEFAULT_ERRORS = ['moromi-error.validation_error']

    # @param [Exception] exception
    # @return [Moromi::Error::Default]
    def self.make(exception)
      return new(debug_message: 'ActiveRecord::RecordInvalid', message: exception.message, errors: [exception.message]) if exception.is_a? ActiveRecord::RecordInvalid

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
  end

  class TooManyRequests < Default
    DEFAULT_CODE = 10005
    DEFAULT_ERRORS = ['moromi-error.too_many_requests']
  end
end

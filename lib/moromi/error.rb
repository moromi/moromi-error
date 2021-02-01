require 'moromi/error/config'
require 'moromi/error/default_logger'
require 'moromi/error/default_information_builder'
require 'moromi/error/engine'
require 'moromi/error/errors'
require 'moromi/error/renderer'
require 'moromi/error/rescue'

module Moromi
  module Error
    def self.configure(&block)
      yield @config ||= Config.new
    end

    def self.config
      @config
    end

    def self.default_severity_mappings
      {
        Moromi::Error::Default => Logger::Severity::DEBUG,
        ActionController::RoutingError => Logger::Severity::WARN
      }
    end

    configure do |config|
      config.debug = false
      config.logger = Moromi::Error::DefaultLogger.new
      config.severity_mappings = default_severity_mappings
      config.information_builder_klass = Moromi::Error::DefaultInformationBuilder
      config.use_exception_notifier = false
    end
  end
end

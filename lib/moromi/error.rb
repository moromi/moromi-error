require 'moromi/error/config'
require 'moromi/error/loggerable'
require 'moromi/error/default_logger'
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

    configure do |config|
      config.debug = false
      config.logger = Moromi::Error::DefaultLogger.new
      config.store_url = ''
    end
  end
end

module Moromi
  module Error
    class Config
      include ActiveSupport::Configurable

      config_accessor :debug
      config_accessor :logger
      config_accessor :information_builder_klass
      config_accessor :severity_mappings
      config_accessor :use_exception_notifier
    end
  end
end

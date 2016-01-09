module Moromi
  module Error
    class Config
      include ActiveSupport::Configurable

      config_accessor :debug
      config_accessor :logger
      config_accessor :store_url
    end
  end
end

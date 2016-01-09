module Moromi
  module Error
    class Engine < ::Rails::Engine
      isolate_namespace Moromi::Error

      config.generators do |g|
        g.test_framework :rspec, fixture: false
      end
    end
  end
end

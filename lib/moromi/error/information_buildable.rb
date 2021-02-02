module Moromi
  module Error
    module InformationBuildable
      def initialize(controller)
        raise NotImplementedError
      end

      def build
        raise NotImplementedError
      end
    end
  end
end

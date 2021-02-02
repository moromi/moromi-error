require 'moromi/error/information_buildable'

module Moromi
  module Error
    class DefaultInformationBuilder
      include ::Moromi::Error::InformationBuildable

      def initialize(controller)
        @controller = controller
      end

      def build
        {
          user_id: fetch_user_id(controller),
          url: fetch_url(controller),
          user_agent: fetch_user_agent(controller)
        }
      end

      private

      def fetch_user_id(controller)
        controller.respond_to?(:current_user) ? controller.current_user&.id : 0
      rescue
        nil
      end

      def fetch_url(controller)
        controller.request.try(:url)
      rescue
        nil
      end

      def fetch_user_agent(controller)
        controller.request.try(:user_agent)
      rescue
        nil
      end
    end
  end
end

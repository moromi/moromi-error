module Moromi
  module Error
    module Loggerable
      def write(controller, status, title, exception, options, locals)
        raise NotImplementedError
      end
    end
  end
end

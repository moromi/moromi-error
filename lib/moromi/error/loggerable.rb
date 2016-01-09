module Moromi
  module Error
    module Loggerable
      def write(status, title, exception, options, locals)
        raise NotImplementedError
      end
    end
  end
end

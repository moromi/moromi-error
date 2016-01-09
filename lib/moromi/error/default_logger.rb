module Moromi
  module Error
    class DefaultLogger
      include Loggerable

      def write(status, title, exception, options, locals)
        return if exception.is_a? Moromi::Error::Default

        messages = ['[ERROR]']
        messages << ([exception.inspect] + (exception&.backtrace || [])).compact.join("\n").gsub("\n", '\n')

        Rails.logger.error(messages.join(' '))
      end
    end
  end
end

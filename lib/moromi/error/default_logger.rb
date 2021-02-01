require 'moromi/error/loggerable'

module Moromi
  module Error
    class DefaultLogger
      include ::Moromi::Error::Loggerable

      UNKNOWN = 'unknown'.freeze

      def write(controller, status, title, exception, options, locals)
        Moromi::Error.config.severity_mappings.each do |klass, severity|
          if exception.is_a? klass
            message = ([exception.message] + ::Rails.backtrace_cleaner.clean(Array(exception.backtrace).compact)).join('\n')
            Rails.logger.add severity, message
            return
          end
        end

        Rails.logger.add log_severity(exception), to_ltsv(controller, exception) unless skip?(exception)
        notify_exception(controller, exception)
      rescue => e
        backtrace = ::Rails.backtrace_cleaner.clean(e.backtrace).join("\n").gsub("\n", '\n')
        Rails.logger.error "[#{self.class}#write] #{e.inspect} #{backtrace}"
      end

      private

      def to_ltsv(controller, exception)
        backtrace = (exception&.backtrace || []).compact
        information_builder = Moromi::Error.config.information_builder_klass.new(controller)

        messages = {
          error_class: exception.class,
          message: exception.message,
          errors: fetch_errors(exception).compact.join("\n").gsub("\n", '\n'),
          backtrace: ::Rails.backtrace_cleaner.clean(backtrace).join("\n").gsub("\n", '\n')
        }
        messages.merge!(information_builder.build)

        messages.map { |k, v| "#{k}:#{v}" }.join("\t")
      rescue
        (exception&.backtrace || []).compact.join("\n").gsub("\n", '\n')
      end

      def notify_exception(controller, exception)
        return unless defined? ExceptionNotifier
        return unless Moromi::Error.config.use_exception_notifier

        ExceptionNotifier.notify_exception(exception, env: controller.request.env, data: {method: controller.request.method, url: controller.request.url})
      end

      def skip?(exception)
        return false unless exception.respond_to?(:skip_logging?)

        exception.skip_logging?
      end

      def log_severity(exception)
        return Logger::Severity::ERROR unless exception.respond_to?(:log_severity)

        exception.log_severity
      end

      def fetch_errors(exception)
        return [exception.inspect] unless exception.respond_to?(:errors)

        exception.errors
      end
    end
  end
end

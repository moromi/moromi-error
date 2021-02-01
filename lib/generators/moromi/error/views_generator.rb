module Moromi
  module Error
    module Generators
      class ViewsGenerator < Rails::Generators::Base
        source_root File.expand_path('../../../../../app/views/moromi/error', __FILE__)

        class_option :template_engine, type: :string, aliases: '-e', desc: 'Template engine for the views. Available options are "erb" and "slim".'

        def self.banner #:nodoc:
          <<-BANNER.chomp
rails g moromi:error:views [options]
    Copies all partial templates to your application.
          BANNER
        end

        desc ''
        def copy_or_fetch #:nodoc:
          copy_html_templates
          copy_jbuilder_templates
          copy_jb_templates
        end

        private

        def copy_html_templates
          filename_pattern = File.join self.class.source_root, "*.html.#{template_engine}"
          Dir.glob(filename_pattern).map {|f| File.basename f}.each do |f|
            copy_file f, "app/views/moromi/error/#{f}"
          end
        end

        def copy_jbuilder_templates
          filename_pattern = File.join self.class.source_root, "*.json.jbuilder"
          Dir.glob(filename_pattern).map {|f| File.basename f}.each do |f|
            copy_file f, "app/views/moromi/error/#{f}"
          end
        end

        def copy_jb_templates
          filename_pattern = File.join self.class.source_root, "*.json.jb"
          Dir.glob(filename_pattern).map {|f| File.basename f}.each do |f|
            copy_file f, "app/views/moromi/error/#{f}"
          end
        end

        def template_engine
          options[:template_engine]&.to_s&.downcase || 'erb'
        end
      end
    end
  end
end

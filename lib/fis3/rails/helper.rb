require 'action_view'
require 'active_support'
require 'fis3/rails/manifest'

module Fis3
  module Rails
    module Helper
      JS_PLACEHOLDER = :fis3_js_placeholder
      CSS_PLACEHOLDER = :fis3_css_placeholder
      JS_SUFFIX = ['.js', '.jsx']
      CSS_SUFFIX = ['.css', '.scss']

      def fis3_javascript_tag(source)
        source = fis3_valid_source(source, JS_SUFFIX)
        return "" if source.blank?

        content_for JS_PLACEHOLDER do
          javascript_include_tag(fis3_asset_path(source))
        end

        if dep_path = fis3_asset_dep_path(source)
          content_for CSS_PLACEHOLDER do
            stylesheet_link_tag(dep_path)
          end
        end
      end

      def fis3_stylesheet_tag(source)
        source = fis3_valid_source(source, CSS_SUFFIX)
        return "" if source.blank?

        content_for CSS_PLACEHOLDER do
          stylesheet_link_tag(fis3_asset_path(source))
        end
      end

      def fis3_valid_source(source, suffixes)
        if suffixes.any?{|suffix| source.end_with?(suffix)}
          return source
        end

        suffixes.each do |suffix|
          ext_source = "#{source}#{suffix}"
          return ext_source if Fis3::Rails::Manifest.is_asset_exist?(ext_source)
        end

        return nil
      end

      def fis3_asset_path(source)
        return "" unless source.present?
        info = Fis3::Rails::Manifest.asset_path(source)
        info[:path]
      end

      def fis3_asset_dep_path(source)
        return "" unless source.present?
        info = Fis3::Rails::Manifest.asset_path(source)
        info[:dep_path]
      end
    end
  end
end

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
        content_for JS_PLACEHOLDER do
          javascript_include_tag(fis3_js_path(source))
        end

        deps = Fis3::Rails::Manifest.asset_css_deps(source)
        if deps.present?
          css_paths = deps.map!{|d| fis3_css_path(d)}.uniq!
          content_for CSS_PLACEHOLDER do
            stylesheet_link_tag *css_paths
          end
        end
      end
      def fis3_stylesheet_tag(source)
        content_for CSS_PLACEHOLDER do
          stylesheet_link_tag(fis3_css_path(source))
        end
      end

      #private
      
      def fis3_css_path(source)
        fis3_smart_asset_path(source, CSS_SUFFIX)
      end
      def fis3_js_path(source)
        fis3_smart_asset_path(source, JS_SUFFIX)
      end
      def fis3_smart_asset_path(source, suffixs)
        if suffixs.any?{|suffix| source.end_with?(suffix)}
          return fis3_asset_path(source)
        end

        suffixs.each do |suffix|
          path = fis3_asset_path("#{source}#{suffix}")
          return path if path.present?
        end
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

module Fis3
  module Rails
    class Manifest
      class << self

        def asset_path(source)
          info = asset_info(source)
          info['aioPkg'] || info['uri'] || ""
        end

        def asset_deps(source)
          info = asset_info(source)
          info['deps'] || []
        end

        def asset_css_deps(source)
          asset_deps(source).select{ |s| s.end_with?(".css") || s.end_with?(".scss") }
        end

        #private
        
        def asset_info(source)
          manifest['res'][source] || {}
        end

        def manifest
          if fis_config.enable_cache
            @manifest ||= load_manifest
          else
            load_manifest
          end
        end

        def load_manifest
          JSON.parse(File.read(manifest_path))
        rescue => e
          raise "Cannot open #{manifest_path} or parse, error: #{e.message}"
        end

        def manifest_path
          ::Rails.root.join(fis_config.output_dir, fis_config.manifest_filename)
          #"/tmp/map.json"
        end

        def fis_config
          ::Rails.configuration.fis3 
          #ActiveSupport::OrderedOptions.new
        end
      end
    end
  end
end

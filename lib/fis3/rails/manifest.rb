module Fis3
  module Rails
    class Manifest
      class << self

        def is_asset_exist?(source)
          info = asset_info(source)
          info.present?
        end

        def asset_path(source)
          info = asset_info(source)
          pkg_name = info['aioPkg']

          # 优先找 'aioPkg' 字段的映射
          if pkg_name.present?
            path = pkg_path(pkg_name)
            dep_path = pkg_dep_path(pkg_name)

            return { path: path, dep_path: dep_path }
          end
            
          path = info['uri'] || ""
          return { path: path }
        end

        def manifest_path=(path)
          @manifest_path = path
        end

        private
      
        # 查找pkg段落
        def pkg_path(pkg_name)
          info = manifest['pkg'][pkg_name]
          info && info['uri']
        end

        # 根据js名称，查找同名的css的路径
        def pkg_dep_path(pkg_name)
          ext_name = File.extname(pkg_name)
          name = File.join(File.dirname(pkg_name), File.basename(pkg_name, ext_name))

          dep_name = ["#{name}.js", "#{name}.css"]
          dep_name.delete(pkg_name)
          dep_info = manifest['pkg'][dep_name.first]

          return nil if dep_info.blank?

          dep_info['uri'] || nil
        end
        
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
          @manifest_path ||= ::Rails.root.join(fis_config.output_dir, fis_config.manifest_filename)
        end

        def fis_config
          ::Rails.configuration.fis3 
        end
      end
    end
  end
end

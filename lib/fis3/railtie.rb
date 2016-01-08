require 'rails'
require 'rails/railtie'
require 'fis3/rails/helper'

module Fis3
  # :nodoc:
  class Railtie < ::Rails::Railtie
    config.after_initialize do
      ActiveSupport.on_load(:action_view) do
        include Fis3::Rails::Helper
      end
    end

    config.fis3 = ActiveSupport::OrderedOptions.new
    config.fis3.output_dir = "public/static"
    config.fis3.manifest_filename = "map.json"
    config.fis3.enable_cache = ::Rails.env.production?

    rake_tasks do
    end
  end
end

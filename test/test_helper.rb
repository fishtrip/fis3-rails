$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'fis3/rails'
require 'fis3/railtie'
require 'minitest/autorun'


module Dummy
  # :nodoc:
  class Application < Rails::Application
    config.eager_load = false
  end
end

Rails.application.initialize!

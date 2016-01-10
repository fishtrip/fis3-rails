require 'test_helper'

describe Fis3::Rails::Manifest, "test manifest" do
  let(:sample) {"#{File.dirname(__FILE__)}/../example/sample.json"}

  before do
    Rails.configuration.fis3.enable_cache = true
    Fis3::Rails::Manifest.manifest_path = sample
  end

  def assert_path_mapping(name, path)
    info = Fis3::Rails::Manifest.asset_path(name) 
    info[:path].must_equal path
  end

  it "css: should return simple css uri" do
    assert_path_mapping "css/mobile/base.scss", "/static/css/mobile/base.css"
  end

  it "css: should return simple css aioPkg" do
    assert_path_mapping "css/mobile/common.scss", "/static/pkg/mobile/common.css"
  end

  it "js: should return simple js uri" do
    assert_path_mapping "js/mobile/base.js", "/static/js/mobile/base.js"
  end

  it "js: should return simple js aioPkg" do
    assert_path_mapping "js/mobile/common.js", "/static/pkg/components/layouts/_mobile_base_js.erb_aio.js"
  end

  it "js: should return js dep path" do
    path = Fis3::Rails::Manifest.asset_path("js/mobile/common.js")
    path[:dep_path].must_equal "/static/pkg/components/layouts/_mobile_base_js.erb_aio.css"
  end
end


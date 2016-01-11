require 'test_helper'
require 'rails'

describe Fis3::Rails::Helper, "test Rails hepler" do

  let(:sample) {"#{File.dirname(__FILE__)}/../example/sample.json"}
  let(:css_holder) { Fis3::Rails::Helper::CSS_PLACEHOLDER }
  let(:js_holder) { Fis3::Rails::Helper::JS_PLACEHOLDER }
  let(:js_suffixes) { Fis3::Rails::Helper::JS_SUFFIX }
  let(:css_suffixes) { Fis3::Rails::Helper::CSS_SUFFIX }

  before do
    Rails.configuration.fis3.enable_cache = true
    Fis3::Rails::Manifest.manifest_path = sample
  end

  include Fis3::Rails::Helper

  it "should has correct css link tag" do
    fis3_valid_source("css/mobile/base", css_suffixes).must_equal "css/mobile/base.scss"
  end
  it "should has correct css link tag" do
    fis3_valid_source("js/mobile/base", js_suffixes).must_equal "js/mobile/base.js"
  end
  it "should has correct js link tag" do
    fis3_asset_path("js/mobile/base.js").must_equal "/static/js/mobile/base.js"
  end
  it "should has correct js link tag" do
    fis3_asset_path("js/mobile/common.js").must_equal "/static/pkg/components/layouts/_mobile_base_js.erb_aio.js"
  end
  it "should has correct js link tag" do
    fis3_dep_asset_path("js/mobile/common.js").must_equal "/static/pkg/components/layouts/_mobile_base_js.erb_aio.css"
  end

end

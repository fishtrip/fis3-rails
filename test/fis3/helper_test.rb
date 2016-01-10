require 'test_helper'
require 'rails'

describe Fis3::Rails::Helper, "test Rails hepler" do

  let(:sample) {"#{File.dirname(__FILE__)}/../example/sample.json"}
  let(:css_holder) { Fis3::Rails::Helper::CSS_PLACEHOLDER }
  let(:js_holder) { Fis3::Rails::Helper::JS_PLACEHOLDER }

  before do
    Rails.configuration.fis3.enable_cache = true
    Fis3::Rails::Manifest.manifest_path = sample
  end

  it "should has correct css link tag" do
  end

end

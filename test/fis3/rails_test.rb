require 'test_helper'

describe Fis3::Rails, "test rails" do
  it "should has version" do
    Fis3::Rails::VERSION.wont_be_nil
  end
end

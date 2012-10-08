require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Interpolator do
  describe "#factory" do
    it "should return a bilinear interpolator when asked" do
      i = Interpolator.factory :bilinear, nil
      i.should be_a_kind_of Interpolator
    end
  end

  describe "#interpolate" do
    it "should take a 2d coordinates and return a pixel" do
      i = Interpolator.factory :bilinear, nil
      p = i.interpolate 2.5, 3.6
    end
  end
end

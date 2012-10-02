# -*- coding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Sphere do
    before :each do
        @instance = Sphere.new Point.new(0, 0, 0), 1
    end

    describe "#new" do
        it "takes two parameters and returns a Sphere object" do
            @instance.should be_an_instance_of Sphere
        end
    end

    describe "#to_lonlat" do
        it "should return (0.5, 0.5) for (1, 0, 0)" do
            lon, lat = @instance.to_lonlat Point.new(1, 0, 0)
            lon.should == 0.5
            lat.should == 0.5
        end

        it "should return (0.25, 0.5) for (0, -1, 0)" do
            lon, lat = @instance.to_lonlat Point.new(0, -1, 0)
            lon.should == 0.25
            lat.should == 0.5
        end

        it "should return (0.75, 0.25) for (0, 1, 0)" do
            lon, lat = @instance.to_lonlat Point.new(0, 1, 0)
            lon.should == 0.75
            lat.should == 0.5
        end
        
        it "should return (0.5, 0.25) for (1, 0, 1)" do
            lon, lat = @instance.to_lonlat Point.new(1, 0, 1)
            lon.should == 0.5
            lat.should be_within(0.001).of(0.25)
        end
    end

  describe "#to_p" do
      it "takes a lon, lat (0.25, 0.5) and returns (0, -1, 0)" do
        p = @instance.to_p(0.25, 0.5)
        p.x.should be_within(0.001).of(0)
        p.y.should be_within(0.001).of(-1)
        p.z.should be_within(0.001).of(0)
      end

      it "takes a lon, lat (0.75, 0.25) and returns (0, 1, 1)" do
        p = @instance.to_p(0.75, 0.25)
        p.x.should be_within(0.001).of(0)
        p.y.should be_within(0.001).of(1)
        p.z.should be_within(0.001).of(1)
      end
      
      it "takes a lon, lat (0.5, 0.5) and returns (1, 0, 0)" do
        p = @instance.to_p(0.5, 0.5)
        p.x.should be_within(0.001).of(1)
        p.y.should be_within(0.001).of(0)
        p.z.should be_within(0.001).of(0)
      end
  end
end

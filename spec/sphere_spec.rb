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
        it "should return the point proportional to the image" do
            lon, lat = @instance.to_lonlat Point.new(1, 0, 0)
            lon.should == 0.5
            lat.should == 0.5
        end

        it "should return the point proportional to the image" do
            lon, lat = @instance.to_lonlat Point.new(0, -1, 0)
            lon.should == 0.75
            lat.should == 0.5
        end

        it "should return the point proportional to the image" do
            lon, lat = @instance.to_lonlat Point.new(0, 1, 0)
            lon.should == 0.25
            lat.should == 0.5
        end
    end
end

# -*- coding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Sphere do
    before :each do
        @instance = Sphere.new Point.new(0, 0, 0), 1
        @inside = Line.new(Point.new(-1, 0, 0), Point.new(1, 0, 0))
        @outside = Line.new(Point.new(1, 2, 0), Point.new(-1, 2, 0))
        @touching = Line.new(Point.new(1, 1, 0), Point.new(-1, 1, 0))
    end

    describe "#new" do
        it "takes two parameters and returns a Sphere object" do
            @instance.should be_an_instance_of Sphere
        end
    end

    describe "#intersects_line" do
        it "takes a line parameter and return true if the line intersects" do
            r = @instance.intersects_line @inside
            r.should be_true
        end

        it "takes a line parameter and return true if the line touches" do
            r = @instance.intersects_line @touching
            r.should be_true
        end

        it "takes a line parameter and return false if the line does not intersects" do
            r = @instance.intersects_line @outside
            r.should be_false
        end
    end

    describe "#intersection_line" do
        it "takes a line and returns nil if there is no intersection" do
            r = @instance.intersection_line @outside
            r.should be_nil
        end

        it "takes a line and returns an array if there is an intersection" do
            r = @instance.intersection_line @inside
            r.should be_an_instance_of Array
        end

        it "takes a line and returns an array with two points if there is two intersections" do
            r = @instance.intersection_line @inside
            r.should be_an_instance_of Array
            r.length.should == 2
            r[0].should be_an_instance_of Point
            r[1].should be_an_instance_of Point
            r.should include @inside.p1
            r.should include @inside.p2
        end

        it "takes a line and returns an array with 1 point if there is one intersection" do
            expect = Point.new 0, 1, 0
            r = @instance.intersection_line @touching
            r.should be_an_instance_of Array
            r.length.should == 1
            r[0].should be_an_instance_of Point
            r[0].should == expect
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

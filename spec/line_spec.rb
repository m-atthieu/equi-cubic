require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Line do
    before :each do
        @inside = Line.new(Point.new(-1, 0, 0) , Point.new(1, 0, 0))
        @outside = Line.new(Point.new(1, 2, 0) , Point.new(-1, 2, 0))
        @touching = Line.new(Point.new(1, 1, 0) , Point.new(-1, 1, 0))
        @unite = Sphere.new(Point.new(0, 0, 0), 1)
    end

    describe "#new" do
        it "should takes two parameters and returns a Line object" do
            @inside.should be_an_instance_of Line
        end
    end

    describe "#direction" do
        it "returns a vector giving the direction of the line" do
            expect = Vector.new Point.new(1, 0, 0)
            r = @inside.direction.norme
            r.should be_an_instance_of Vector
            r.scalar(expect).abs.should == 1
        end
    end

    describe "#colinear" do
        it "should return true if the line is colinear to a vector" do
            v = Vector.new Point.new(1, 0, 0)
            r = @inside.colinear v
            r.should be_true
        end
    end

    describe "#instersects_sphere" do
        it "takes a sphere parameter and return true if the sphere intersects" do
            r = @inside.intersects_sphere @unite
            r.should be_true
        end

        it "takes a sphere parameter and return false if the sphere does not intersects" do
            r = @outside.intersects_sphere @unite
            r.should be_false
        end
    end

    describe "#intersection_sphere" do
        it "takes a sphere and returns nil if there is no intersection" do
            r = @outside.intersection_sphere @unite
            r.should be_nil
        end

        it "takes a sphere and returns an array if there is an intersection" do
            r = @inside.intersection_sphere @unite
            r.should be_an_instance_of Array
        end

        it "takes a sphere and returns an array with two correct  points if there is two intersections" do
            e1 = Point.new 1, 0, 0
            e2 = Point.new -1, 0, 0
            r = @inside.intersection_sphere @unite
            r.should be_an_instance_of Array
            r.length.should == 2
            r[0].should be_an_instance_of Point
            r.should include e1
            r.should include e2
        end

        it "takes a sphere and returns an array with 1 correct point if there is one intersection" do
            expect = Point.new 0, 1, 0
            r = @touching.intersection_sphere @unite
            r.should be_an_instance_of Array
            r.length.should == 1
            r[0].should be_an_instance_of Point
            r[0].should == expect
        end
    end
end

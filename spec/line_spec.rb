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
end

require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Face do
    before :each do
        @instance = Face.new Point.new(1, 0, 0), 2
    end
    
    describe "#new" do
        it "should take a point and return a face" do
            @instance.should be_an_instance_of Face
        end
    end
    
    describe "#size" do
        it "should return the length of the face" do
            @instance.size.should == 2
        end
    end
    
    describe "#to_p" do
        it "should return a point (3d)" do
            expect = Point.new(1, -1, 1)
            p = @instance.to_p(0, 0)
            p.should be_an_instance_of Point
            p.should == expect
        end
    end
end
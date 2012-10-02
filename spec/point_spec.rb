require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Point do
    before :each do
        @instance = Point.new 1, 2, 1
    end

    describe "#new" do
        it "should takes three parameters and returns a Point object" do
            @instance.should be_an_instance_of Point
        end
    end
    
    describe "#*" do
        it "should multiply each coordinates by term" do
            @instance.*(2).should == Point.new(2, 4, 2)
        end
    end
    
    describe "#distance" do
        it "returns the distance to the origin (0, 0, 0)" do
      p1 = Point.new 0, 0, 0
            p2 = Point.new 2, 0, 0
            expect = 2
            p2.distance(p1).should == expect
        end
        
        it "should return the distance between two points anywhere" do
            p1 = Point.new 0, 0, 0
            p2 = Point.new 2, 2, 2
            expect = 2 * Math.sqrt(3)
            p2.distance(p1).should == expect
        end
    end
end

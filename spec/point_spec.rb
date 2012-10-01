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
        it "should return the distance between two points" do
            p1 = Point.new 0, 0, 0
            p2 = Point.new 2, 0, 0
            expect = 2
            p1.distance(p2).should == expect
        end
        
        it "should return the distance between two points anywhere" do
            p1 = Point.new -1, -1, -1
            p2 = Point.new 1, 1, 1
            expect = 2 * Math.sqrt(3)
            p1.distance(p2).should == expect
        end
    end
end

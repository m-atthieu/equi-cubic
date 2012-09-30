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
end

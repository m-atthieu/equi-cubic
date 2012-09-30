require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe LonLat do
    before :each do
        @instance = LonLat.new 0, 0
    end

    describe "#new" do
        it "should takes two parameters and returns a LontLat object" do
            @instance.should be_an_instance_of LonLat
        end
    end
end

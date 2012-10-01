require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Cube do
    before :each do
        @instance = Cube.new Point.new(0, 0, 0), 2
    end
    
    describe "#new" do
        it 'should take a point (center) and a face size' do
            @instance.should be_an_instance_of Cube
        end
    end
    
    describe "#center" do
        it "should return the central point of the cube" do
            @instance.center.should == Point.new(0, 0, 0)
        end
    end
    
    describe "#face" do
        it "should take a face symbol and return the said face" do
            face = @instance.face(:FACE_X_POS)
            face.should be_an_instance_of Face
        end
    end
end
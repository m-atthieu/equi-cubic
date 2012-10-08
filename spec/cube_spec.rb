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
            face.should be_a_kind_of Face
        end
    end

    describe "#face_name_from_point p" do
        it "should return :FACE_X_POS for (1, 0, 0)" do
            @instance.face_name_from_point(Point.new(1, 0, 0)).should == :FACE_X_POS
        end

        it "should return :FACE_X_NEG for (-1, 0, 0)" do
            @instance.face_name_from_point(Point.new(-1, 0, 0)).should == :FACE_X_NEG
        end

    it "should return :FACE_Y_NEG for (0, 1, 0)" do
            @instance.face_name_from_point(Point.new(0, 1, 0)).should == :FACE_Y_POS
        end

it "should return :FACE_Y_NEG for (0, -1, 0)" do
            @instance.face_name_from_point(Point.new(0, -1, 0)).should == :FACE_Y_NEG
        end

it "should return :FACE_Y_NEG for (0, 0, 1)" do
            @instance.face_name_from_point(Point.new(0, 0, 1)).should == :FACE_Z_POS
        end

it "should return :FACE_Y_NEG for (0, 0, -1)" do
            @instance.face_name_from_point(Point.new(0, 0, -1)).should == :FACE_Z_NEG
        end
    end
end

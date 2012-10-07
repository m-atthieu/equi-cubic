require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Face do
    describe "#to_uv" do
        context "down face" do
            let(:face){ Face.new Point.new(0, 0, -16), 32}
            context 'point in A' do
                it "should return correct u, v" do
                    p = Point.new 10, 8, -16
                    u, v = face.to_uv p
                    u.should == 8
                    v.should == 6
                end
            end
            context 'point in B' do
                it "should return correct u, v" do
                    p = Point.new 2, 8, -16
                    u, v = face.to_uv p
                    u.should == 8
                    v.should == 14
                end
            end
            context 'point in C' do
                it "should return correct u, v" do
                    p = Point.new 2, -4, -16
                    u, v = face.to_uv p
                    u.should == 20
                    v.should == 14
                end
            end
            context 'point in D' do
                it "should return correct u, v" do
                    p = Point.new -4, 2, -16
                    u, v = face.to_uv p
                    u.should == 14
                    v.should == 20
                end
            end
            context 'point in E' do
                it "should return correct u, v" do
                    p = Point.new -4, -2, -16
                    u, v = face.to_uv p
                    u.should == 18
                    v.should == 20
                end
            end
        end
    end
end
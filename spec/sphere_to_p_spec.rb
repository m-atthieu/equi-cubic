require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Sphere do
    describe "#to_p" do
        let(:sphere){ Sphere.new Point.new(0, 0, 0), 32 } 
        context "lon, lat on front face" do
            it 'should have each coordinates on the right place' do
                p = sphere.to_p(0.45, 0.2)
                p.x.should > 0
                p.y.should > 0
                p.z.should > 0
            end
        end
        context "lon, lat on right face" do
            it 'should have each coordinates on the right place' do
                p = sphere.to_p(0.7, 0.43)
                p.x.should > 0
                p.y.should < 0
                p.z.should > 0
            end
        end
        context "lon, lat on left face" do
            it 'should have each coordinates on the right place' do
                p = sphere.to_p(0.2, 0.63)
                p.x.should < 0
                p.y.should > 0
                p.z.should < 0
            end
        end
        context "lon, lat on up face" do
            it 'should place a point in A' do
                p = sphere.to_p(0.4, 0.05)
                p.x.should > 0
                p.y.abs.should < p.x
                p.z.should > 16
            end
            it 'should place a point in B' do
                p = sphere.to_p(0.2, 0.1)
                p.x.abs.should < p.y
                p.y.should > 0
                p.z.should > 16
            end
            it 'should place a point in C' do
                p = sphere.to_p(0.7, 0.08)
                p.x.abs.should < p.y.abs
                p.y.should < 0
                p.z.should > 16
            end
            it 'should place a point in D' do
                p = sphere.to_p(0.1, 0.1)
                p.x.should < 0
                p.y.should > 0
                p.z.should > 16
            end
            it 'should place a point in E' do
                p = sphere.to_p(0.9, 0.05)
                p.x.should < 0
                p.y.should < 0
                p.z.should > 16
            end
        end
        context "lon, lat on down face" do
            it 'should place a point in A' do
                p = sphere.to_p(0.4, 0.9)
                p.x.should > 0
                p.y.abs.should < p.x
                p.z.should < -16
            end
            it 'should place a point in B' do
                p = sphere.to_p(0.2, 0.85)
                p.x.abs.should < p.y
                p.y.should > 0
                p.z.should < -16
            end
            it 'should place a point in C' do
                p = sphere.to_p(0.65, 0.88)
                p.x.abs.should < p.y.abs
                p.y.should < 0
                p.z.should < -16
            end
            it 'should place a point in D' do
                p = sphere.to_p(0.02, 0.97)
                p.x.should < 0
                p.y.should > 0
                p.z.should < -16
            end
            it 'should place a point in E' do
                p = sphere.to_p(0.98, 0.78)
                p.x.should < 0
                p.y.should < 0
                p.z.should < -16
            end
        end
        context "lon, lat on back face" do
            it 'should place a point in G' do
                p = sphere.to_p(0.95, 0.4)
                p.x.should < 0
                p.y.should < 0
                p.z.should > 0
            end
            it 'should place a point in D' do
                p = sphere.to_p(0.05, 0.3)
                p.x.should < 0
                p.y.should > 0
                p.z.should > 0
            end
        end
    end
end
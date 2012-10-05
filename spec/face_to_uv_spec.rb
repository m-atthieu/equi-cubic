require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Face do
    describe "#to_uv" do
        context "with :FACE_X_NEG" do
            let(:face){ Face.new Point.new(-16, 0, 0), 32}
            
            def check_abcd_order a, b, c, d
                ua, va = face.to_uv a
                ub, vb = face.to_uv b
                uc, vc = face.to_uv c
                ud, vd = face.to_uv d
                ua.should < ub
                uc.should < ud
                va.should > vc
                vb.should > vd
            end
   
            context "quadrant yp zp" do
                let(:a){ Point.new -16, 4, 4 }
                let(:b){ Point.new -16, 8, 4 }
                let(:c){ Point.new -16, 4, 8 }
                let(:d){ Point.new -16, 8, 8 }
                it "should be in ordre" do
                    check_abcd_order a, b, c, d
                end
            end
            context "quadrant yn zp" do
                let(:a){ Point.new -16, -8, 4 }
                let(:b){ Point.new -16, -4, 4 }
                let(:c){ Point.new -16, -8, 8 }
                let(:d){ Point.new -16, -4, 8 }
                it "should be in ordre" do
                    check_abcd_order a, b, c, d
                end
            end
            context "quadrant yn zn" do
                let(:a){ Point.new -16, -8, -8 }
                let(:b){ Point.new -16, -4, -8 }
                let(:c){ Point.new -16, -8, -4 }
                let(:d){ Point.new -16, -4, -4 }
                it "should be in ordre" do
                    check_abcd_order a, b, c, d
                end
            end
            context "quadrant yp zn" do
                let(:a){ Point.new -16, 4, -8 }
                let(:b){ Point.new -16, 8, -8 }
                let(:c){ Point.new -16, 4, -4 }
                let(:d){ Point.new -16, 8, -4 }
                it "should be in ordre" do
                    check_abcd_order a, b, c, d
                end
            end
        end
    end
end
                    
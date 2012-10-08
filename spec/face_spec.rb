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
    let(:a){ Point.new( 1, -1,  1) }
    let(:b){ Point.new( 1,  1,  1) }
    let(:c){ Point.new( 1, -1, -1) }
    let(:d){ Point.new( 1,  1, -1) }
    let(:e){ Point.new(-1, -1,  1) }
    let(:f){ Point.new(-1,  1,  1) }
    let(:g){ Point.new(-1,  1, -1) }
    let(:h){ Point.new(-1, -1, -1) }

    def check_p face, x, y, p
      face.to_p(x, y).should == p
    end

    context "with :FACE_X_POS" do
      let(:face){ Face.create :FACE_X_POS, 1 }
      it "should return top left correctly"     do check_p face, 0, 0, b end
      it "should return top right correctly"    do check_p face, 2, 0, a end
      it "should return bottom left correctly"  do check_p face, 0, 2, d end
      it "should return bottom right correctly" do check_p face, 2, 2, c end
    end

    context "with :FACE_X_NEG" do
      let(:face){ Face.create :FACE_X_NEG, 1 }
      it "should return top left correctly"     do check_p face, 0, 0, e end
      it "should return top right correctly"    do check_p face, 2, 0, f end
      it "should return bottom left correctly"  do check_p face, 0, 2, h end
      it "should return bottom right correctly" do check_p face, 2, 2, g end
    end

    context "with :FACE_Y_POS" do
      let(:face){ Face.create :FACE_Y_POS, 1 }
      it "should return top left correctly"     do check_p face, 0, 0, f end
      it "should return top right correctly"    do check_p face, 2, 0, b end
      it "should return bottom left correctly"  do check_p face, 0, 2, g end
      it "should return bottom right correctly" do check_p face, 2, 2, d end
    end

    context "with :FACE_Y_NEG" do
      let(:face){ Face.create :FACE_Y_NEG, 1 }
      it "should return top left correctly"     do check_p face, 0, 0, a end
      it "should return top right correctly"    do check_p face, 2, 0, e end
      it "should return bottom left correctly"  do check_p face, 0, 2, c end
      it "should return bottom right correctly" do check_p face, 2, 2, h end
    end

    context "with :FACE_Z_POS" do
      let(:face){ Face.create :FACE_Z_POS, 1 }
      it "should return top left correctly"     do check_p face, 0, 0, f end
      it "should return top right correctly"    do check_p face, 2, 0, e end
      it "should return bottom left correctly"  do check_p face, 0, 2, b end
      it "should return bottom right correctly" do check_p face, 2, 2, a end
    end

    context "with :FACE_Z_NEG" do
      let(:face){ Face.create :FACE_Z_NEG, 1 }
      it "should return top left correctly"     do check_p face, 0, 0, d end
      it "should return top right correctly"    do check_p face, 2, 0, c end
      it "should return bottom left correctly"  do check_p face, 0, 2, g end
      it "should return bottom right correctly" do check_p face, 2, 2, h end
    end
  end

  describe "#to_uv" do
    let(:a){ Point.new( 1, -1,  1) }
    let(:b){ Point.new( 1,  1,  1) }
    let(:c){ Point.new( 1, -1, -1) }
    let(:d){ Point.new( 1,  1, -1) }
    let(:e){ Point.new(-1, -1,  1) }
    let(:f){ Point.new(-1,  1,  1) }
    let(:g){ Point.new(-1,  1, -1) }
    let(:h){ Point.new(-1, -1, -1) }

    let(:ul){ { :u => 0, :v => 0 } }
    let(:ur){ { :u => 2, :v => 0 } }
    let(:bl){ { :u => 0, :v => 2 } }
    let(:br){ { :u => 2, :v => 2 } }

    def check_uv face, u, v, p
      face.to_uv(p).should == [u, v]
    end

    context "with :FACE_X_POS" do
      let(:face){ Face.create :FACE_X_POS, 1 }
      it "should return top left correctly"     do check_uv face, 0, 0, b end
      it "should return top right correctly"    do check_uv face, 2, 0, a end
      it "should return bottom left correctly"  do check_uv face, 0, 2, d end
      it "should return bottom right correctly" do check_uv face, 2, 2, c end
    end
    
    context "with :FACE_X_NEG" do
      let(:face){ Face.create :FACE_X_NEG, 1 }
      it "should return top left correctly"     do check_uv face, 0, 0, e end
      it "should return top right correctly"    do check_uv face, 2, 0, f end
      it "should return bottom left correctly"  do check_uv face, 0, 2, h end
      it "should return bottom right correctly" do check_uv face, 2, 2, g end
    end

    context "with :FACE_Y_POS" do
      let(:face){ Face.create :FACE_Y_POS, 1 }
      it "should return top left correctly"     do check_uv face, 0, 0, f end
      it "should return top right correctly"    do check_uv face, 2, 0, b end
      it "should return bottom left correctly"  do check_uv face, 0, 2, g end
      it "should return bottom right correctly" do check_uv face, 2, 2, d end
    end

    context "with :FACE_Y_NEG" do
      let(:face){ Face.create :FACE_Y_NEG, 1 }
      it "should return top left correctly"     do check_uv face, 0, 0, a end
      it "should return top right correctly"    do check_uv face, 2, 0, e end
      it "should return bottom left correctly"  do check_uv face, 0, 2, c end
      it "should return bottom right correctly" do check_uv face, 2, 2, h end
    end

    context "with :FACE_Z_POS" do
      let(:face){ Face.create :FACE_Z_POS, 1 }
      it "should return top left correctly"     do check_uv face, 0, 0, f end
      it "should return top right correctly"    do check_uv face, 2, 0, e end
      it "should return bottom left correctly"  do check_uv face, 0, 2, b end
      it "should return bottom right correctly" do check_uv face, 2, 2, a end
    end

    context "with :FACE_Z_NEG" do
      let(:face){ Face.create :FACE_Z_NEG, 1 }
      it "should return top left correctly"     do check_uv face, 0, 0, d end
      it "should return top right correctly"    do check_uv face, 2, 0, c end
      it "should return bottom left correctly"  do check_uv face, 0, 2, g end
      it "should return bottom right correctly" do check_uv face, 2, 2, h end
    end
  end
end

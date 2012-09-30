describe Vector do
    before :each do
        @instance = Vector.new Point.new(0, 0, 3)
        @instance2 = Vector.new Point.new(0, 4, 0)
        @instance3 = Vector.new Point.new(0, 0, -3)
    end
    describe "#norme" do
        it "return the vector where the length is 1" do
            v = @instance.norme.length
            v.should == 1
        end
    end

    describe "#length" do
        it "return the length of the vector" do
            r = @instance.length
            r.should == 3
        end
    end

    describe "#orthogonal_product" do
        it "returns the orthogonal_product vector of two vectors" do
            v = @instance.orthogonal_product @instance2
            r = v.scalar_product @instance
            r.should == 0
            r = v.scalar_product @instance2
            r.should == 0
        end
    end

    describe "#scalar_product" do
        it "returns the scalar product" do
            r = @instance.scalar_product @instance2
            r.should be_an_instance_of Fixnum
        end

        it "return the inverse if one of the vector is inversed" do
            r = @instance.norme.scalar_product @instance3.norme
            r.should == -1
        end

        it "returns 0 if vectors are orthogonal" do
            r = @instance.scalar_product @instance2
            r.should == 0
        end
    end
end

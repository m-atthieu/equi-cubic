describe Plan do
    before :each do
        @parallel = Line.new Point.new(1, 1, 1), Point.new(-1, 1, 1)
        @normal = Line.new Point.new(1, 1, -1), Point.new(1, 1, 1)
        @instance = Plan.new Point.new(1, 1, 0), Point.new(-1, 1, 0), Point.new(-1, -1, 0)
    end

    describe "#new" do
        it "takes three points and returns a Plan instance" do
            @instance.should be_an_instance_of Plan
        end
    end

    describe "#orthogonal" do
        it "return the orthogonal vector to the plane" do
            r = @instance.orthogonal.norme
            d = @normal.direction.norme
            r.should be_an_instance_of Vector
            r.produit_scalaire(d).should == 1
        end
    end

    describe "#intersects_line" do
        it "takes a line parrelel to the plane and return false" do
            r = @instance.intersects_line @parallel
            r.should be_false
        end
        it "takes a line orthogonal to the plane and return true" do
            r = @instance.intersects_line @normal
            r.should be_true
        end
    end
end

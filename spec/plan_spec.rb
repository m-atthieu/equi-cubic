describe Plan do
    before :each do
    @instance = Plan.new Point.new(1, 1, 0), Point.new(-1, 1, 0), Point.new(-1, -1, 0)
    end

    describe "#new" do
        it "takes three points and returns a Plan instance" do
            @instance.should be_an_instance_of Plan
        end
    end
end

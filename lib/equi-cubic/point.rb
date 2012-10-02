class Point
    attr_reader :x, :y, :z
    def initialize x, y, z
        @x = x
        @y = y
        @z = z
    end
    def == p
        return @x.to_f == p.x.to_f && @y.to_f == p.y.to_f && @z.to_f == p.z.to_f
    end

    def to_v
        return Vector.new self
    end
    
    def * term
        return Point.new @x * term, @y * term, @z * term
    end
    
    def distance
        return Math.sqrt(@x * @x + @y * @y + @z*@z)
        #return Math.sqrt((@x - o.x) * (@x - o.x) + (@y - o.y) * (@y - o.y) + (@z - o.z) * (@z - o.z))
    end
end

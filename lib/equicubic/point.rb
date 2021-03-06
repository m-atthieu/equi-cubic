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
      Math.sqrt(@x * @x + @y * @y + @z * @z)
    end

    def to_s
      "(#{@x}, #{@y}, #{@z})"
    end

    #alias :distance :distance2
end

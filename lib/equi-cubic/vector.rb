class Vector
    attr_reader :x, :y, :z

    def initialize p1, p2=nil
        if p2.nil? then
            @x = p1.x
            @y = p1.y
            @z = p1.z
        else
            @x = p2.x - p1.x
            @y = p2.y - p1.y
            @z = p2.z - p1.z
        end
    end

    def to_p
        Point.new @x, @y, @z
    end

    def dot other
        return @x * other.x + @y * other.y + @z * other.z
    end

    def -(other)
        p = Point.new @x - other.x, @y - other.y, @z - other.z
        return p.to_v
    end

    # produit vectoriel
    def orthogonal_product v
        return Vector.new(
                      Point.new((@y * v.z - @z * v.y),
                      (@z * v.x - @x * v.z),
                      (@x * v.y - @y * v.x)))
    end

    def length
        return Math.sqrt(@x ** 2 + @y ** 2 + @z ** 2)
    end

    def scalar_product other
        return @x * other.x + @y * other.y + @z * other.z
    end
    alias :produit_scalaire :scalar_product
    alias :scalar :scalar_product

    def norme
        return Vector.new Point.new(@x / length, @y / length, @z / length)
    end

    def == other
        return self.unit == other.unit
    end
end

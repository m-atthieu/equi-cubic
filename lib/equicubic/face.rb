class Face
    attr_reader :size
    def initialize point, size
        @center = point
        @size = size
        @s = size / 2
    end

    @@face_point = {
        :FACE_X_POS => Point.new( 1,  0,  0),
        :FACE_X_NEG => Point.new(-1,  0,  0),
        :FACE_Y_POS => Point.new( 0,  1,  0),
        :FACE_Y_NEG => Point.new( 0, -1,  0),
        :FACE_Z_POS => Point.new( 0,  0,  1),
        :FACE_Z_NEG => Point.new( 0,  0, -1)
    }

    def self.create face, coeff
        if face == :FACE_X_POS then
            Face_x_pos.new @@face_point[face] * coeff, coeff * 2
        elsif face == :FACE_X_NEG then
            Face_x_neg.new @@face_point[face] * coeff, coeff * 2
        elsif face == :FACE_Y_POS then
            Face_y_pos.new @@face_point[face] * coeff, coeff * 2
        elsif face == :FACE_Y_NEG then
            Face_y_neg.new @@face_point[face] * coeff, coeff * 2
        elsif face == :FACE_Z_NEG then
            Face_z_neg.new @@face_point[face] * coeff, coeff * 2
        elsif face == :FACE_Z_POS then
            Face_z_pos.new @@face_point[face] * coeff, coeff * 2
        end
    end
end

class Face_x_pos < Face
    def to_p u, v
        return Point.new @s, @s - u, @s - v
    end

    def to_uv p
        return @s - p.y, @s - p.z
    end
end

class Face_y_pos < Face
    def to_p x, y
        return Point.new -@s + x, @s, @s - y
    end

    def to_uv p
        return @s + p.x, @s - p.z
    end
end

class Face_y_neg < Face
    def to_p x, y
        return Point.new @s - x, -@s, @s - y
    end

    def to_uv p
        return @s - p.x, @s - p.z
    end

end

class Face_x_neg < Face
    def to_p x, y
        return Point.new -@s, -@s + x, @s - y
    end

    def to_uv p
        return p.y + @s, @s - p.z
    end
end

class Face_z_pos < Face
    def to_uv p
       return @s - p.y, @s + p.x
    end
    def to_p x, y
        Point.new -@s + y, @s - x, @s
    end
end

class Face_z_neg < Face
    def to_uv p
       return @s - p.y, @s - p.x
    end
    def to_p x, y
        Point.new @s - y, @s - x, -@s
    end
end

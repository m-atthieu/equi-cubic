class Face
    attr_reader :size
    def initialize point, size
        @center = point
        @size = size
        @s = size / 2
        switch_to_p
    end
    
    def switch_to_p
        if @center.x != 0 then
          if @center.x >= 0 then
              alias :to_p xp_to_p
          else
              alias :to_p xn_to_p
          end
        elsif @center.y != 0 then
          if @center.y >= 0 then
              alias :to_p yp_to_p
          else
            alias :to_p yn_to_p
          end
        else
          if @center.z >= 0 then
              alias :to_p zp_to_p
          else
            alias :to_p zn_to_p
          end
        end
    end
    
    def xp_to_p x, y
        return Point.new @s, @s - x, @s - y
    end
    
    def xn_to_p x, y
        return Point.new -@s, -@s + x, @s - y
    end
    
    def yp_to_p x, y
        return Point.new -@s + x, @s, @s - y
    end
    
    def yn_to_p x, y
        return Point.new @s - x, -@s, @s - y
    end
    
    def zp_to_p x, y
        return Point.new -@s + y, @s - x, @s
    end
    
    def zn_to_p x, y
        return Point.new @s - y, @s - x, -@s
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
        return Face.new @@face_point[face] * coeff, coeff * 2
    end
end

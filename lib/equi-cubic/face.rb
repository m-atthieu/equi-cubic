class Face < Plan
    attr_reader :size
    
    def initialize point, size
        @center = point
        @size = size
    end
    
    def to_p x, y
        if @center.x != 0 then
          if @center.x >= 0 then
            return Point.new @size / 2, @size / 2 - x, @size / 2 - y
          else
            return Point.new -@size / 2, -@size / 2 + x, @size / 2 - y
          end
        elsif @center.y != 0 then
          if @center.y >= 0 then
            return Point.new -@size / 2 + x, @size / 2, @size / 2 - y
          else
            return Point.new @size / 2 - x, -@size / 2, @size / 2 - y
          end
        else
          if @center.z >= 0 then
            return Point.new -@size / 2 + y, @size / 2 - x, @size / 2
          else
            return Point.new @size / 2 - y, @size / 2 - x, - @size / 2
          end
        end
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

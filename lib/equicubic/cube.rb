class Cube
    attr_accessor :center
    
    def initialize center, size
        @center = center
        @size = size
        @faces = Hash.new
    end
    
    def face f
        if not @faces.has_key? f then
            @faces[f] = Face.create f, @size / 2
        end
        return @faces[f]
    end

    def face_name_from_point p
        m = [p.x.abs, p.y.abs, p.z.abs].max
        if m == p.x.abs then
            if p.x >= 0 then
                :FACE_X_POS
            else
                :FACE_X_NEG
            end
        elsif m == p.y.abs then
            if p.y >= 0 then
                :FACE_Y_POS
            else
                :FACE_Y_NEG
            end
        else
            if p.z >= 0 then
                :FACE_Z_POS
            else
                :FACE_Z_NEG
            end
        end
    end
end
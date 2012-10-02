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
end
class Transformer
    def initialize 
    end
    
    def equi_cubic image
        height = image.first.rows
        if height * 2 != image.first.columns then
            puts "height * 2 != width"
            exit 1
        end
        r = height / Math::PI
        c = Cube.new Point.new(0, 0, 0), 2 * r
        s = Sphere.new Point.new(0, 0, 0), r
        o = Point.new 0, 0, 0
        faces = {}
        [:FACE_X_POS, :FACE_X_NEG, :FACE_Y_POS, :FACE_Y_NEG, :FACE_Z_POS, :FACE_Z_NEG].each do |face_name|
            face = Magick::Image.new 2 * r, 2 * r
            f = c.face face_name
            (0..face.rows).each do |x|
                (0..face.columns).each do |y|
                    p = f.to_p x, y
                    lon, lat = s.to_lonlat p
                    face.pixel_color x, y, image.first.pixel_color(lon * image.first.columns, lat * image.first.rows)
                end
            end
            faces[face_name] = face
        end
        return faces
    end
    
    def cubic_equi faces
        height = faces[:FACE_X_POS].height
    end
end
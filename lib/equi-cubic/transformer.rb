class Transformer
    def initialize 
    end
    
    def transform image
        height = image.first.rows
        if height * 2 != image.first.columns then
            puts "height * 2 != width"
            exit 1
        end
        r = height / Math::PI
        c = Cube.new Point.new(0, 0, 0), 2 * r
        s = Sphere.new Point.new(0, 0, 0), r
        o = Point.new 0, 0, 0
        # face x pos
        xp = Magick::Image.new 2 * r, 2 * r
        f = c.face :FACE_X_POS
        (0..xp.rows).each do |x|
            (0..xp.columns).each do |y|
                p = f.to_p x, y
                l = Line.new o, p
                sols = s.intersection_line l
                if(p.distance(sols[0]) < p.distance(sols[1])) then
                    lon, lat = s.to_lonlat sols[0]
                else
                    lon, lat = s.to_lonlat sols[1]
                end
                xp.pixel_color x, y, image.first.pixel_color(lon * image.first.columns, lat * image.first.rows)
            end
        end
        faces = {
            :FACE_X_POS => xp
        }
        return faces
    end
end
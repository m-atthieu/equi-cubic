class Transformer
    def equi_cubic image
      image = image.clone
        height = image.first.rows
        if height * 2 != image.first.columns then
            puts "height * 2 != width"
            exit 1
        end
        r = height / Math::PI
        cube = Cube.new Point.new(0, 0, 0), 2 * r
        sphere = Sphere.new Point.new(0, 0, 0), r
        faces = Hash.new
        [:FACE_X_POS, :FACE_X_NEG, :FACE_Y_POS, :FACE_Y_NEG, :FACE_Z_POS, :FACE_Z_NEG].each do |face_name|
            face_img = Magick::Image.new 2 * r + 2, 2 * r + 2
            face = cube.face face_name
            (0..face_img.rows).each do |x|
                (0..face_img.columns).each do |y|
                    p = face.to_p x, y
                    lon, lat = sphere.to_lonlat_c p
                    face_img.pixel_color x, y, image.first.pixel_color(lon * image.first.columns, lat * image.first.rows)
                end
            end
            faces[face_name] = face_img
        end
        return faces
    end

    def cubic_equi faces
      height = (faces[:FACE_X_POS].first.rows / 2) * Math::PI
      width = 2 * height
      cube = Cube.new Point.new(0, 0, 0), faces[:FACE_X_POS].first.rows
      sphere = Sphere.new Point.new(0, 0, 0), faces[:FACE_X_POS].first.rows / 2
      image = Magick::Image.new width, height
      (0..image.rows).each do |x|
        (0..image.columns).each do |y|
          lon, lat = x / image.rows, y / image.columns
          p = sphere.to_p lon, lat
          fn = cube.face_name_from_point p
          face = cube.face fn
          u, v = face.to_uv p
          image.pixel_color x, y, faces[fn].first.pixel_color(u, v)
        end
      end
      return image
    end
end

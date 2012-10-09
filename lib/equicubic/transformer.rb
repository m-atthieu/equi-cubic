class Transformer

  def set_interpolator inter
    @interpolator = inter
  end

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
            face_img = Magick::Image.new((2 * r).ceil(), (2 * r).ceil())
            face = cube.face face_name
            (0..face_img.rows).each do |x|
                (0..face_img.columns).each do |y|
                    p = face.to_p x, y
                    lon, lat = sphere.to_lonlat_c p
                    u, v = lon * image.first.columns, lat * image.first.rows
                    pixel = @interpolator.interpolate_c u, v
                    face_img.pixel_color x, y, pixel
                end
            end
            faces[face_name] = face_img
        end
        return faces
    end

    def cubic_equi faces
      height = ((faces[:FACE_X_POS].first.rows) * 1.0 / 2) * Math::PI
      width = 2 * height
      cube = Cube.new Point.new(0, 0, 0), (height / Math::PI) * 2
      sphere = Sphere.new Point.new(0, 0, 0), (height / Math::PI)
      image = Magick::Image.new width, height
      (0..image.columns).each do |x|
        (0..image.rows).each do |y|
          lon, lat = (x * 1.0) / width, (y * 1.0) / height
          p = sphere.to_p_c lon, lat
          fn = cube.face_name_from_point p
          face = cube.face fn
          u, v = face.to_uv p
          p = @interpolator[fn].interpolate_c u, v
          image.pixel_color x, y, p
        end
      end
      return image
    end
end

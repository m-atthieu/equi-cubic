module EquiToCubic
  class BilinearInterpolator < Interpolator
    def set_image image
      image = image.first
      width = image.columns
      height = image.rows
      @image = image.border(1, 1, "white").crop(1, 1, width + 1, height + 1, true)
      height.times do |h|
        @image.pixel_color(width, h, @image.pixel_color(0, h))
      end
      width.times do |w|
        @image.pixel_color(w, height, @image.pixel_color(width - w - 1, height - 1))
      end
      @image.pixel_color(width, height, @image.pixel_color(0, height - 1))
      # @image.write("interpolator.png")
    end

    # interpolate/interpolate_c in c_ext.c
  end
end

module CubicToEqui
  class BilinearInterpolator < Interpolator
    attr_reader :image
    def set_image center, up, down, left, right
      width = center.columns
      height = center.rows
      @image = center.border(1, 1, 'white')
      height.times do |h|
        @image.pixel_color(0, h + 1, left.pixel_color(width - 1, h))
        @image.pixel_color(width + 1, h + 1, right.pixel_color(0, h))
      end
      width.times do |w|
        @image.pixel_color(w + 1, 0, up.pixel_color(w, height - 1))
        @image.pixel_color(w + 1, height + 1, down.pixel_color(w, 0))
      end
    end
    # interpolate/interpolate_c in c_ext.c
  end
end

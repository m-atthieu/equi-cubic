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
    @image.write("interpolator.png")
  end

  # interpolate/interpolate_c in c_ext.c
end

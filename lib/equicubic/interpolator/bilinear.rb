class BilinearInterpolator < Interpolator
  def set_image image
    super image
    @width = @image.columns
    @height = @image.rows
  end

  # interpolate/interpolate_c in c_ext.c
end

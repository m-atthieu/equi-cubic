class NoneInterpolator < Interpolator
  def interpolate u, v
    return @image.pixel_color u, v
  end
end

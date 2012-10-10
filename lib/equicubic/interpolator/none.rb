class NoneInterpolator
  def interpolate u, v
    return @image.pixel_color u, v
  end
end

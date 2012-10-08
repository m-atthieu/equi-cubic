class Interpolator
  def self.factory name, image
    if name == :bilinear then
      instance = BilinearInterpolator.new
    end
    instance.set_image image
    return instance
  end

  def set_image image
    @image = image.first
  end

  def interpolate u, v
  end
end

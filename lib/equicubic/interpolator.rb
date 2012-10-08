class Interpolator
  def self.factory name, image
    if name == :bilinear then
      instance = BilinearInterpolator.new
    elsif name == :bicubic then
      instance = BicubicInterpolator.new
    elsif name == :none then
      instance = NoneInterpolator.new
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

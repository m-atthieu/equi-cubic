class Sphere
  def initialize origin, radius
    @origin = origin
    @radius = radius
  end

  def to_lonlat point
    phi = Math.acos(point.z / point.distance_c)
    theta = Math.acos(point.x / Math.sqrt(point.x * point.x + point.y * point.y))
    if point.y < 0 then
        theta = Math::PI + theta
    else
        theta = Math::PI - theta
    end
    return theta / (2 * Math::PI), phi / Math::PI
  end

  def to_p lon, lat
    rho = @radius
    phi = lat * Math::PI
    if lon > 0.5 then
      theta =  3 * Math::PI - 2 * Math::PI * lon
    else
      theta = Math::PI - 2 * Math::PI * lon
    end
    x = rho * Math.sin(phi) * Math.cos(theta)
    y = rho * Math.sin(phi) * Math.sin(theta)
    z = rho * Math.cos(phi)
    p = Point.new x, y, z
    max = [x.abs, y.abs, z.abs].max
    if max == x.abs then
        coeff = @radius / x.abs
    elsif max == y.abs then
        coeff = @radius / y.abs
    elsif max == z.abs then
        coeff = @radius / z.abs
    end
    return p * coeff
  end
end

class Sphere
  def initialize origin, radius
    @origin = origin
    @radius = radius
  end

  def to_lonlat point
    phi = Math.acos(point.z / point.distance)
    begin
      theta = Math.acos(point.x / Math.sqrt(point.x * point.x + point.y * point.y))
    rescue
      puts "error computing acos with #{point.x} & #{point.y}"
      theta = 0
    end
    if point.y < 0 then
      theta = Math::PI + theta
      else
      theta = Math::PI - theta
    end
    return theta / (2 * Math::PI), phi / Math::PI
  end
end

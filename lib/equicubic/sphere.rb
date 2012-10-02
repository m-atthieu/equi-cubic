class Sphere
  def initialize origin, radius
    @origin = origin
    @radius = radius
  end

  def to_lonlat point
    d = point.distance
    return to_lonlat2 point.x, point.y, point.z, d
  end
end

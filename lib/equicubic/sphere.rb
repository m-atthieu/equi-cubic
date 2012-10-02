class Sphere
    def initialize origin, radius
        @origin = origin
        @radius = radius
    end

    def to_lonlat point
      #rho = point.distance @origin
        phi = Math.acos(point.z / point.distance)
        theta = Math.acos(point.x / Math.sqrt(point.x * point.x + point.y * point.y))
        if point.y < 0 then
          theta = theta + Math::PI
        else
            theta = Math::PI - theta
        end
        return theta / (2 * Math::PI), phi / Math::PI
    end
end

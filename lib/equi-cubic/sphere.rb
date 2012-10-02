class Sphere
    def initialize origin, radius
        @origin = origin
        @radius = radius
    end

    def to_lonlat point
        rho = @origin.distance point
        phi = Math.acos(point.z / rho)
        theta = Math.acos(point.x / Math.sqrt(point.x ** 2 + point.y ** 2))
        if point.y < 0 then
          theta = theta + Math::PI
        else
            theta = Math::PI - theta
        end
        return theta / (2 * Math::PI), phi / Math::PI
    end
end

class Sphere
    def initialize origin, radius
        @origin = origin
        @radius = radius
    end

    def intersection_line line
        sol = solve_line line
        if sol[:d] < 0 then
            return nil
        else
            u1 = (- sol[:b] + Math.sqrt(sol[:d])) / (2 * sol[:a])
            u2 = (- sol[:b] - Math.sqrt(sol[:d])) / (2 * sol[:a])
            if sol[:d] == 0 then
                return [Point.new(line.p1.x + u1 * (line.p2.x - line.p1.x),
                              line.p1.y + u1 * (line.p2.y - line.p1.y),
                              line.p1.z + u1 * (line.p2.z - line.p1.z))]
            else
                return [Point.new(line.p1.x + u1 * (line.p2.x - line.p1.x),
                              line.p1.y + u1 * (line.p2.y - line.p1.y),
                              line.p1.z + u1 * (line.p2.z - line.p1.z)),
                Point.new(line.p1.x + u2 * (line.p2.x - line.p1.x),
                      line.p1.y + u2 * (line.p2.y - line.p1.y),
                      line.p1.z + u2 * (line.p2.z - line.p1.z))]
            end
        end
    end

    def intersects_line line
        sol = solve_line line
        return sol[:d] >= 0
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

    private
    def solve_line line
        u = line.vecteur_directeur
        pa = line.p1
        a = u.x ** 2 + u.y ** 2 + u.z ** 2
        b = - 2 * u.x * @origin.x + 2 * u.x * pa.x - 2 * u.y * @origin.y + 2 * u.y * pa.y - 2 * u.z * @origin.z + 2 * u.z * pa.z
        c = pa.x ** 2 + pa.y ** 2 + pa.z ** 2 + @origin.x ** 2 + @origin.y ** 2 + @origin.z ** 2 - 2 * pa.x * @origin.x - 2 * pa.y * @origin.y - 2 * pa.z * @origin.z - @radius ** 2
        return {
            :a => a,
            :b => b,
            :c => c,
            :d => b ** 2 - 4 * a * c
        }
    end
end

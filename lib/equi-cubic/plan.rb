# equation de plan : a.x + b.y + c.z + d = 0
class Plan
    def initialize p1, p2, p3
        @p1 = p1
        @p2 = p2
        @p3 = p3
    end

    def orthogonal
        v1 = Vector.new @p1, @p2
        v2 = Vector.new @p1, @p3
        v3 = v1.orthogonal_product v2
        return v3
    end

    def intersects_line line
        d = line.direction.norme
        s = orthogonal.norme.produit_scalaire d
        return s.abs == 1
    end
end

# -*- coding: utf-8 -*-
class Line
    attr_reader :p1, :p2
    def initialize p1, p2
        #l1 = Vector.new(p1).length
        #l2 = Vector.new(p2).length
        #if l1 > l2 then
        #    @p1 = p2
        #    @p2 = p1
        #else
            @p1 = p1
            @p2 = p2
        #end
    end

    def intersects_sphere s
        s.intersects_line self
    end

    def intersection_sphere s
        s.intersection_line self
    end

    def colinear vector
        scalar = self.direction.norme.produit_scalaire vector.norme
        return scalar.abs == 1
    end

    def direction
        return Vector.new @p1, @p2
    end
    alias :vecteur_directeur :direction
end

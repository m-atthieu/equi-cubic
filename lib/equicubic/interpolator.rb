module EquiToCubic
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
end

module CubicToEqui
  class Interpolator
    def self.factory_bilinear images
      a = {
        :FACE_X_POS => BilinearInterpolator.new,
        :FACE_X_NEG => BilinearInterpolator.new,
        :FACE_Y_POS => BilinearInterpolator.new,
        :FACE_Y_NEG => BilinearInterpolator.new,
        :FACE_Z_POS => BilinearInterpolator.new,
        :FACE_Z_NEG => BilinearInterpolator.new
      }
      a[:FACE_X_POS].set_image(images[:FACE_X_POS],
                         images[:FACE_Z_POS],
                         images[:FACE_Z_NEG],
                         images[:FACE_Y_POS],
                         images[:FACE_Y_NEG])
      a[:FACE_X_NEG].set_image(images[:FACE_X_NEG],
                         images[:FACE_Z_POS].rotate(180),
                         images[:FACE_Z_NEG].rotate(180),
                         images[:FACE_Y_NEG],
                         images[:FACE_Y_POS])
      a[:FACE_Y_POS].set_image(images[:FACE_Y_POS],
                         images[:FACE_Z_POS].rotate(-90),
                         images[:FACE_Z_NEG].rotate(90),
                         images[:FACE_X_NEG],
                         images[:FACE_X_POS])
      a[:FACE_Y_NEG].set_image(images[:FACE_Y_NEG],
                         images[:FACE_Z_POS].rotate(90),
                         images[:FACE_Z_NEG].rotate(-90),
                         images[:FACE_X_POS],
                         images[:FACE_X_NEG])
      a[:FACE_Z_POS].set_image(images[:FACE_Z_POS],
                         images[:FACE_X_NEG].rotate(180),
                         images[:FACE_X_POS],
                         images[:FACE_Y_POS].rotate(90),
                         images[:FACE_Y_NEG].rotate(-90))
      a[:FACE_Z_NEG].set_image(images[:FACE_Z_NEG],
                         images[:FACE_X_POS],
                         images[:FACE_X_NEG].rotate(180),
                         images[:FACE_Y_POS].rotate(-90),
                         images[:FACE_Y_NEG].rotate(90))
      return a
    end

    def self.factory name, images
      if name == :none then
        return {
          :FACE_X_POS => NoneInterpolator.new.set_image(images[:FACE_X_POS]),
          :FACE_X_NEG => NoneInterpolator.new.set_image(images[:FACE_X_NEG]),
          :FACE_Y_POS => NoneInterpolator.new.set_image(images[:FACE_Y_POS]),
          :FACE_Y_NEG => NoneInterpolator.new.set_image(images[:FACE_Y_NEG]),
          :FACE_Z_POS => NoneInterpolator.new.set_image(images[:FACE_Z_POS]),
          :FACE_Z_NEG => NoneInterpolator.new.set_image(images[:FACE_Z_NEG])
        }
      elsif name == :bilinear then
        instance = factory_bilinear images
        # debug
        names = {
          :FACE_X_POS => 'f',
          :FACE_X_NEG => 'b',
          :FACE_Y_POS => 'l',
          :FACE_Y_NEG => 'r',
          :FACE_Z_POS => 'u',
          :FACE_Z_NEG => 'd'
        }
        #instance.each do |n, v|
        #  v.image.write("interpolator_#{names[n]}.png")
        #end
        return instance
      end
    end
  end
end

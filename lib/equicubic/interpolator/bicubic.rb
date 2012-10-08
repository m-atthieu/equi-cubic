# -*- coding: utf-8 -*-
class BicubicInterpolator < Interpolator
  def interpolate u, v
    p  = extract u, v
    pr = p.map{ |i| i.map{ |pi| pi.red   } }
    pg = p.map{ |i| i.map{ |pi| pi.green } }
    pb = p.map{ |i| i.map{ |pi| pi.blue  } }
    #puts pr.inspect
    _r = Bicubic.get pr, u, v
    _g = Bicubic.get pg, u, v
    _b = Bicubic.get pb, u, v
    puts "r: #{_r}, g: #{_g}, b: #{_b}"
    return Magick::Pixel.new _r, _g, _b, 255
  end

  private
  def extract u, v
    [
      [
        @image.pixel_color(u.floor - 1, v.floor - 1),
        @image.pixel_color(u.floor    , v.floor - 1),
        @image.pixel_color(u.ceil     , v.floor - 1),
        @image.pixel_color(u.ceil  + 1, v.floor - 1),
      ],
      [
        @image.pixel_color(u.floor - 1, v.floor),
        @image.pixel_color(u.floor    , v.floor),
        @image.pixel_color(u.ceil     , v.floor),
        @image.pixel_color(u.ceil + 1, v.floor),
      ],
      [
        @image.pixel_color(u.floor - 1, v.ceil),
        @image.pixel_color(u.floor    , v.ceil),
        @image.pixel_color(u.ceil     , v.ceil),
        @image.pixel_color(u.ceil  + 1, v.ceil),
      ],
      [
        @image.pixel_color(u.floor - 1, v.ceil + 1),
        @image.pixel_color(u.floor    , v.ceil + 1),
        @image.pixel_color(u.ceil     , v.ceil + 1),
        @image.pixel_color(u.ceil  + 1, v.ceil + 1),
      ]
    ]
  end
end

class Cubic
  def self.get1 p, x
    return p[1] + 0.5 * x *(p[2] - p[0] + x * (2.0 * p[0] - 5.0 * p[1] + 4.0 * p[2] - p[3] + x * (3.0 * (p[1] - p[2]) + p[3] - p[0])));
  end
end

class Bicubic < Cubic
  # p: matrice 4x4 des coefficients
  # x: coordonnÃ©e x oÃ¹ interpoler
  # y: coordonnÃ©e y oÃ¹ interpoler
  def self.get p, x, y
    a = [
      get1(p[0], y),
      get1(p[1], y),
      get1(p[2], y),
      get1(p[3], y)
    ]
    return get1(a, x)
  end
end

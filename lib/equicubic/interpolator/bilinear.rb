class BilinearInterpolator < Interpolator
  def set_image image
    super image
    @width = @image.columns
    @height = @image.rows
  end

  def interpolate u, v
      q = extract u, v
    if u.floor != u.ceil then
      a = (u.ceil - u) / (u.ceil - u.floor)
      b = (u - u.floor) / (u.ceil - u.floor)
    else
      a = 1
      b = 0
    end
    if v.floor != v.ceil then
      c = (v.ceil - v) / (v.ceil - v.floor)
      d = (v - v.floor) / (v.ceil - v.floor)
    else
      c = 1
      d = 0
    end
    _r = c * a * q[0][0].red + c * b * q[0][1].red + d * a * q[1][0].red + d * b * q[1][1].red
    _g = c * a * q[0][0].green + c * b * q[0][1].green + d * a * q[1][0].green + d * b * q[1][1].green
    _b = c * a * q[0][0].blue + c * b * q[0][1].blue + d * a * q[1][0].blue + d * b * q[1][1].blue
    return Magick::Pixel.new _r, _g, _b, 255
  end

private
  def extract_r u, v
    extract(u, v).map{ |i| i.map{ |j| j.red } }
  end

  def extract_g u, v
    extract(u, v).map{ |i| i.map{ |j| j.green } }
  end

  def extract_b u, v
    extract(u, v).map{ |i| i.map{ |j| j.blue } }
  end

  def extract u, v
      uf = u.floor
      uc = u.ceil % @width
      vf = v.floor
      vc = v.ceil
      [
          [ @image.pixel_color(uf, vf), @image.pixel_color(uc, vf) ],
          [ @image.pixel_color(uf, vc), @image.pixel_color(uc, vc) ]
      ]
    end
end

class BilinearInterpolator < Interpolator
  def set_image image
    super image
    @width = @image.columns
    @height = @image.rows
  end

  def interpolate u, v
    qr = extract_r u, v
    qg = extract_g u, v
    qb = extract_b u, v
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
    _r = c * a * qr[0][0] + c * b * qr[0][1] + d * a * qr[1][0] + d * b * qr[1][1]
    _g = c * a * qg[0][0] + c * b * qg[0][1] + d * a * qg[1][0] + d * b * qg[1][1]
    _b = c * a * qb[0][0] + c * b * qb[0][1] + d * a * qb[1][0] + d * b * qb[1][1]
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
    [
      [
        @image.pixel_color(u.floor, v.floor),
        @image.pixel_color(u.ceil % @width, v.floor)
      ],
      [
        @image.pixel_color(u.floor, v.ceil),
        @image.pixel_color(u.ceil % @width, v.ceil)
      ]
    ]
  end
end

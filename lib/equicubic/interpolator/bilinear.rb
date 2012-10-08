class BilinearInterpolator < Interpolator
  def interpolate u, v
    q11 = u.floor, v.ceil
    q12 = u.floor, v.floor
    q22 = u.ceil, v.floor
    q21 = u.ceil, v.ceil
    # R1 = ((x2 - x) / (x2 - x1)) * Q11 + ((x - x1) / (x2 - x1)) * Q21
    # r1 = a * q11 + b * q21
    # R2 = ((x2 - x) / (x2 - x1)) * Q12 + ((x - x1) / (x2 - x1)) * Q22
    # r2 = a * q12 + b * q22
    # P  = ((y2 - y) / (y2 - y1)) *  R1 + ((y - y1) / (y2 - y1)) *  R2
    # p = c * r1 + d * r2
    # p = c * a * q11 + c * b * q21 + d * a * q12 + d * b * q22
    x = u
    y = v
    x1 = q11[0]
    x2 = q21[0]
    y1 = q11[1]
    y2 = q22[1]
    if x1 != x2 then
      a = (x2 - x) / (x2 - x1)
      b = (x - x1) / (x2 - x1)
    else
      a = 1
      b = 0
    end
    if y1 != y2 then
      c = (y2 - y) / (y2 - y1)
      d = (y - y1) / (y2 - y1)
    else
      c = 1
      d = 0
    end
    #puts @image.pixel_color(x1, y1).red
    #puts "x1:#{x1}, x2:#{x2}, y1:#{y1}, y2:#{y2}"
    #puts "a:#{a}, b:#{b}, c:#{c}, d:#{d}"
    _r  = c * a * @image.pixel_color(x1, y1).red
    _r += c * b * @image.pixel_color(x2, y1).red
    _r += d * a * @image.pixel_color(x1, y2).red
    _r += d * b * @image.pixel_color(x2, y2).red
    _g  = c * a * @image.pixel_color(x1, y1).green
    _g += c * b * @image.pixel_color(x2, y1).green
    _g += d * a * @image.pixel_color(x1, y2).green
    _g += d * b * @image.pixel_color(x2, y2).green
    _b  = c * a * @image.pixel_color(x1, y1).blue
    _b += c * b * @image.pixel_color(x2, y1).blue
    _b += d * a * @image.pixel_color(x1, y2).blue
    _b += d * b * @image.pixel_color(x2, y2).blue
    #puts "#{_r}, #{_g}, #{_b}"
    Magick::Pixel.new _r, _g, _b, 255
  end
end

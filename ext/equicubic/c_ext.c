#include <ruby.h>
#include <math.h>

static VALUE sphere_to_lonlat(VALUE self, VALUE x, VALUE y, VALUE z, VALUE distance)
{
    double _x = NUM2DBL(x), _y = NUM2DBL(y), _z = NUM2DBL(z), _d = NUM2DBL(distance);
    VALUE arr = rb_ary_new2(2);
    double phi = acos(z / distance);
    double theta = acos(_x / sqrt(_x * _x + _y * _y));
    if(_y < 0){
	theta = theta + M_PI;
    } else {
	theta = M_PI - theta;
    }
    rb_ary_push(arr, rb_float_new(theta / (2 * M_PI)));
    rb_ary_push(arr, rb_float_new(phi / M_PI));
    return arr;
}

static VALUE point_distance(VALUE self)
{
    double _x = NUM2DBL(rb_iv_get(self, "@x")), 
	_y = NUM2DBL(rb_iv_get(self, "@y")), 
	_z = NUM2DBL(rb_iv_get(self, "@z"));
    return rb_float_new(sqrt(_x * _x + _y * _y + _z * _z));
}

void Init_c_ext(void)
{
	VALUE sphere = rb_define_class("Sphere", rb_cObject);
	rb_define_method(sphere, "to_lonlat_c", sphere_to_lonlat, 4);

	VALUE point = rb_define_class("Point", rb_cObject);
	rb_define_method(point, "distance_c", point_distance, 0);
}

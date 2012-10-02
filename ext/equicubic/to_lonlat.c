#include <ruby.h>
#include <math.h>

static VALUE equicubic_to_lonlat(VALUE self, VALUE x, VALUE y, VALUE z, VALUE distance)
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

void Init_to_lonlat(void)
{
	/* assume we haven't yet defined Hola */
	VALUE klass = rb_define_class("Sphere", rb_cObject);
	/* the hola_bonjour function can be called
	 * from ruby as "Hola.bonjour" */
	rb_define_method(klass, "to_lonlat2", equicubic_to_lonlat, 4);

	Init_distance();
}

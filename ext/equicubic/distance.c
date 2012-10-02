#include <ruby.h>
#include <math.h>

static VALUE point_distance(VALUE self)
{
    double _x = NUM2DBL(rb_iv_get(self, "@x")), 
	_y = NUM2DBL(rb_iv_get(self, "@y")), 
	_z = NUM2DBL(rb_iv_get(self, "@z"));
    return rb_float_new(sqrt(_x * _x + _y * _y + _z * _z));
}

void Init_distance(void)
{
	/* assume we haven't yet defined Hola */
	VALUE klass = rb_define_class("Point", rb_cObject);
	/* the hola_bonjour function can be called
	 * from ruby as "Hola.bonjour" */
	rb_define_method(klass, "distance2", point_distance, 0);
}

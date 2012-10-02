#include <ruby.h>

static VALUE equicubic_to_lonlat(VALUE self)
{
}

void Init_equicubic(void)
{
	/* assume we haven't yet defined Hola */
	VALUE klass = rb_define_class("Sphere", rb_cObject);
	/* the hola_bonjour function can be called
	 * from ruby as "Hola.bonjour" */
	rb_define_singleton_method(klass, "to_lonlat2", equicubic_to_lonlat, 0);
}

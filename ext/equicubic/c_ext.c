#include <ruby.h>
#include <math.h>
#include <stdio.h>

static VALUE point_class = 0;

static VALUE sphere_to_lonlat(VALUE self, VALUE point)
{
    ID distance_m = rb_intern("distance_c");
    VALUE distance = rb_funcall(point, distance_m, 0);
	
    double _x = NUM2DBL(rb_iv_get(point, "@x")), 
	_y = NUM2DBL(rb_iv_get(point, "@y")), 
	_z = NUM2DBL(rb_iv_get(point, "@z")), 
	_d = NUM2DBL(distance);
    VALUE arr = rb_ary_new2(2);
    double phi = acos(_z / _d);
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

static VALUE sphere_to_p(VALUE self, VALUE lon, VALUE lat)
{
    double rho = NUM2DBL(rb_iv_get(self, "@radius")),
	_lon = NUM2DBL(lon),
	_lat = NUM2DBL(lat);
    double phi = _lat * M_PI;
    double theta = 0;
    if(_lon > 0.5){
		theta = 3 * M_PI - 2 * M_PI * _lon;
    } else {
		theta = M_PI - 2 * M_PI * _lon;
    }
    double x = rho * sin(phi) * cos(theta);
    double y = rho * sin(phi) * sin(theta);
    double z = rho * cos(phi);
	//printf("\nlon : %f, lat: %f\n", _lon, _lat);
	//printf("\tx : %f, rho : %f, sin phi : %f, cos theta : %f\n", x, rho, sin(phi), cos(theta));
	//printf("\ty : %f, rho : %f, sin phi : %f, sin theta : %f\n", y, rho, sin(phi), sin(theta));
	//printf("\tz : %f, rho : %f, cos phi : %f\n", z, rho, sin(phi));
    double coeff = 1.;
    if(fabs(x) > fabs(y) && fabs(x) > fabs(z)){
		//printf("max x\n");
		coeff = rho / fabs(x);
    } else if(fabs(y) > fabs(x) && fabs(y) > fabs(z)){
		//printf("max y\n");
		coeff = rho / fabs(y);
    } else {
		//printf("\trho: %f, abs z: %f\n", rho, fabs(z));
		coeff = rho / fabs(z);
    }
    x *= coeff; y*= coeff; z *= coeff;
	//printf("\tc:%f, x: %f, y: %f, y: %f\n", coeff, x, y, z);
    VALUE argv[3];
    argv[0] = rb_float_new(x);
    argv[1] = rb_float_new(y);
    argv[2] = rb_float_new(z);
    return rb_class_new_instance(3, argv, rb_path2class("Point"));
}

static VALUE point_distance(VALUE self)
{
    double _x = NUM2DBL(rb_iv_get(self, "@x")), 
	_y = NUM2DBL(rb_iv_get(self, "@y")), 
	_z = NUM2DBL(rb_iv_get(self, "@z"));
    return rb_float_new(sqrt(_x * _x + _y * _y + _z * _z));
}

VALUE bilinear_interpolate(VALUE self, VALUE u, VALUE v)
{
    double _u = NUM2DBL(u),
	_v = NUM2DBL(v);
    long _width = FIX2LONG(rb_iv_get(self, "@width")),
	_height = FIX2LONG(rb_iv_get(self, "@height"));
    long uf = floor(_u),
	uc = ceil(_u),
	vf = floor(_v),
	vc = ceil(_v);
    double a, b, c, d;
    if(uf != uc){
	a = (uc - _u) / (uc - uf);
	b = (_u - uf) / (uc - uf);
    } else {
	a = 1;
	b = 0;
    }
    if(vf != vc){
	c = (vc - _v) / (vc - vf);
	d = (_v - vf) / (vc - vf);
    } else {
	c = 1;
	d = 0;
    }
    ID pixel_color = rb_intern("pixel_color"),
	red = rb_intern("red"),
	green = rb_intern("green"),
	blue = rb_intern("blue");
    VALUE _image = rb_iv_get(self, "@image");
    int q00x = uf, q00y = vf, q01x = uc, q01y = vf,
	q10x = uf, q10y = vc, q11x = uc, q11y = vc;
    VALUE q00 = rb_funcall(_image, pixel_color, 2, INT2FIX(q00x), INT2FIX(q00y)),
	q01 = rb_funcall(_image, pixel_color, 2, INT2FIX(q01x), INT2FIX(q01y)),
	q10 = rb_funcall(_image, pixel_color, 2, INT2FIX(q10x), INT2FIX(q10y)),
	q11 = rb_funcall(_image, pixel_color, 2, INT2FIX(q11x), INT2FIX(q11y));
    long q00r = FIX2LONG(rb_funcall(q00, red, 0)),
	q00g = FIX2LONG(rb_funcall(q00, green, 0)),
	q00b = FIX2LONG(rb_funcall(q00, blue, 0)),
	q01r = FIX2LONG(rb_funcall(q01, red, 0)),
	q01g = FIX2LONG(rb_funcall(q01, green, 0)),
	q01b = FIX2LONG(rb_funcall(q01, blue, 0)),
	q10r = FIX2LONG(rb_funcall(q10, red, 0)),
	q10g = FIX2LONG(rb_funcall(q10, green, 0)),
	q10b = FIX2LONG(rb_funcall(q10, blue, 0)),
	q11r = FIX2LONG(rb_funcall(q11, red, 0)),
	q11g = FIX2LONG(rb_funcall(q11, green, 0)),
	q11b = FIX2LONG(rb_funcall(q11, blue, 0));
    long _r = c * a * q00r + c * b * q01r + d * a * q10r + d * b * q11r, 
	_g = c * a * q00g + c * b * q01g + d * a * q10g + d * b * q11g,
	_b = c * a * q00b + c * b * q01b + d * a * q10b + d * b * q11b;
    VALUE rgba[4] = { INT2FIX(_r), INT2FIX(_g), INT2FIX(_b), INT2FIX(255) };
    return rb_class_new_instance(4, rgba, rb_path2class("Magick::Pixel"));
}

void Init_c_ext(void)
{
	VALUE sphere = rb_define_class("Sphere", rb_cObject);
	rb_define_method(sphere, "to_lonlat_c", sphere_to_lonlat, 1);
	rb_define_method(sphere, "to_p_c", sphere_to_p, 2);

	point_class = rb_define_class("Point", rb_cObject);
	rb_define_method(point_class, "distance_c", point_distance, 0);

	VALUE equitocubic_module = rb_define_module("EquiToCubic");
	VALUE interpolator_class_ec = rb_define_class_under(equitocubic_module, "Interpolator", rb_cObject);
	VALUE bilinear_class_ec = rb_define_class_under(equitocubic_module, "BilinearInterpolator", interpolator_class_ec);
	rb_define_method(bilinear_class_ec, "interpolate_c", bilinear_interpolate, 2);

	VALUE cubictoequi_module = rb_define_module("CubicToEqui");
	VALUE interpolator_class_ce = rb_define_class_under(cubictoequi_module, "Interpolator", rb_cObject);
	VALUE bilinear_class_ce = rb_define_class_under(cubictoequi_module, "BilinearInterpolator", interpolator_class_ce);
	rb_define_method(bilinear_class_ce, "interpolate_c", bilinear_interpolate, 2);

}

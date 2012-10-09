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

#define _q_(a, c, x, y) FIX2LONG(rb_funcall(rb_ary_entry(rb_ary_entry(a, x), y), c, 0))

VALUE bilinear_interpolate(VALUE self, VALUE u, VALUE v)
{
    double _u = NUM2DBL(u),
	_v = NUM2DBL(v);
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
    ID extract = rb_intern("extract"),
		red = rb_intern("red"),
	green = rb_intern("green"),
	blue = rb_intern("blue");
    VALUE argv[2] = {u, v};
    VALUE q = rb_funcall2(self, extract, 2, argv);
    long _r = c * a * _q_(q, red, 0, 0) + c * b * _q_(q, red, 0, 1) + d * a * _q_(q, red, 1, 0) + d * b * _q_(q, red, 1, 1), 
	_g = c * a * _q_(q, green, 0, 0) + c * b * _q_(q, green, 0, 1) + d * a * _q_(q, green, 1, 0) + d * b * _q_(q, green, 1, 1), 
	_b = c * a * _q_(q, blue, 0, 0) + c * b * _q_(q, blue, 0, 1) + d * a * _q_(q, blue, 1, 0) + d * b * _q_(q, blue, 1, 1);
    VALUE rgba[4] = { INT2FIX(_r), INT2FIX(_g), INT2FIX(_b), INT2FIX(255) };
    return rb_class_new_instance(4, rgba, rb_path2class("Magick::Pixel"));
}

#undef _q_

void Init_c_ext(void)
{
	VALUE sphere = rb_define_class("Sphere", rb_cObject);
	rb_define_method(sphere, "to_lonlat_c", sphere_to_lonlat, 1);
	rb_define_method(sphere, "to_p_c", sphere_to_p, 2);

	point_class = rb_define_class("Point", rb_cObject);
	rb_define_method(point_class, "distance_c", point_distance, 0);

	VALUE interpolator_class = rb_define_class("Interpolator", rb_cObject);
	VALUE bilinear_class = rb_define_class("BilinearInterpolator", interpolator_class);
	rb_define_method(bilinear_class, "interpolate_c", bilinear_interpolate, 2);
}

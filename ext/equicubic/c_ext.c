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
    long q11x = floor(_u),
	q11y = ceil(_v),
	q12x = floor(_u),
	q12y = floor(_v),
	q22x = ceil(_u),
	q22y = floor(_v),
	q21x = ceil(_u),
	q21y = ceil(_v);
    double a, b, c, d;
    if(q11x != q21x){
	a = (q21x - _u) / (q11x - q21x);
	b = (_u - q11x) / (q11x - q21x);
    } else {
	a = 1;
	b = 0;
    }
    if(q11y != q22y){
	c = (q22y - _v) / (q22y - q11y);
	d = (_v - q11y) / (q22y - q11y);
    } else {
	c = 1;
	d = 0;
    }
    VALUE image = rb_iv_get(self, "@image");
    ID pixel_color = rb_intern("pixel_color"),
	red = rb_intern("red"),
	green = rb_intern("green"),
	blue = rb_intern("blue");
    VALUE argv[2];
    argv[0] = INT2FIX(q11x);
    argv[1] = INT2FIX(q11y);
    VALUE q11 = rb_funcall2(image, pixel_color, 2, argv);
    long q11r = FIX2LONG(rb_funcall(q11, red, 0)),
	q11g = FIX2LONG(rb_funcall(q11, green, 0)),
	q11b = FIX2LONG(rb_funcall(q11, blue, 0));
    argv[0] = INT2FIX(q12x);
    argv[1] = INT2FIX(q12y);
    VALUE q12 = rb_funcall2(image, pixel_color, 2, argv);
    long q12r = FIX2LONG(rb_funcall(q12, red, 0)),
	q12g = FIX2LONG(rb_funcall(q12, green, 0)),
	q12b = FIX2LONG(rb_funcall(q12, blue, 0));
    argv[0] = INT2FIX(q21x);
    argv[1] = INT2FIX(q21y);
    VALUE q21 = rb_funcall2(image, pixel_color, 2, argv);
    long q21r = FIX2LONG(rb_funcall(q21, red, 0)),
	q21g = FIX2LONG(rb_funcall(q21, green, 0)),
	q21b = FIX2LONG(rb_funcall(q21, blue, 0));
    argv[0] = INT2FIX(q22x);
    argv[1] = INT2FIX(q22y);
    VALUE q22 = rb_funcall2(image, pixel_color, 2, argv);
    long q22r = FIX2LONG(rb_funcall(q22, red, 0)),
	q22g = FIX2LONG(rb_funcall(q22, green, 0)),
	q22b = FIX2LONG(rb_funcall(q22, blue, 0));
    long _r = c * a * q11r + c * b * q21r + d * a * q12r + d * b * q22r,
	_g = c * a * q11g + c * b * q21g + d * a * q12g + d * b * q22g,
	_b = c * a * q11b + c * b * q21b + d * a * q12b + d * b * q22b;
    VALUE new[4];
    new[0] = INT2FIX(-_r);
    new[1] = INT2FIX(-_g);
    new[2] = INT2FIX(-_b);
    new[3] = INT2FIX(255);
    return rb_class_new_instance(4, new, rb_path2class("Magick::Pixel"));
}

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

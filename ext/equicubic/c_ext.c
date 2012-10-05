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



void Init_c_ext(void)
{
	VALUE sphere = rb_define_class("Sphere", rb_cObject);
	rb_define_method(sphere, "to_lonlat_c", sphere_to_lonlat, 1);
	rb_define_method(sphere, "to_p_c", sphere_to_p, 2);

	point_class = rb_define_class("Point", rb_cObject);
	rb_define_method(point_class, "distance_c", point_distance, 0);
}

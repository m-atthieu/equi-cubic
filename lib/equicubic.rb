$: << File.dirname(__FILE__) + '/../ext'

require 'equicubic/c_ext'
require 'equicubic/point'
require 'equicubic/sphere'
require 'equicubic/cube'
require 'equicubic/face'
require 'equicubic/transformer'

require 'equicubic/interpolator'
require 'equicubic/interpolator/bilinear'
require 'equicubic/interpolator/bicubic'
require 'equicubic/interpolator/none'

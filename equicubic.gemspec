Gem::Specification.new do |s|
  s.name        = 'equicubic'
  s.version     = '0.0.0'
  s.date        = '2010-04-28'
  s.summary     = "Hola!"
  s.description = "A simple hello world gem"
  s.authors     = ["Matthieu DESILE"]
  s.email       = 'matthieu@desile.fr'
  s.files       = Dir['lib/**/*.rb'] + Dir['bin/*'] + Dir.glob('ext/**/*.{c,h,rb}')
  s.extensions  = ['ext/equicubic/extconf.rb']
  s.homepage    = 'http://github.com/furai/equi-cubic'
  s.executables << 'equi-cubic'
  s.executables << 'cubic-equi'
end

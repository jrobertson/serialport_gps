Gem::Specification.new do |s|
  s.name = 'serialport_gps'
  s.version = '0.1.0'
  s.summary = 'Fetches, and converts GPS coordinates using the SerialPort gem.'
  s.authors = ['James Robertson']
  s.files = Dir['lib/**/*.rb']
  s.add_dependency('nmea_parser')
  s.add_dependency('run_every')
  s.add_dependency('serialport')
  s.signing_key = '../privatekeys/serialport_gps.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@r0bertson.co.uk'
  s.homepage = 'https://github.com/jrobertson/serialport_gps'
  s.required_ruby_version = '>= 2.1.2'
end

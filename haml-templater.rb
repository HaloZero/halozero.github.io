require 'haml'
require 'json'

template = ARGV.length > 0 ? File.read(ARGV.shift) : STDIN.read

haml_engine = Haml::Engine.new(template)

file = ARGV.length > 0 ? File.open(ARGV.shift, 'w') : STDOUT

config_file = File.open('config.json', 'r')

configuration = JSON.parse(config_file.read)

arguments = {
  config: configuration
}

file.write(haml_engine.render(Object.new, arguments))
file.close

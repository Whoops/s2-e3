require 'adventure'
require 'yaml'

config=YAML.load_file(ARGV[0])

Adventure.run config
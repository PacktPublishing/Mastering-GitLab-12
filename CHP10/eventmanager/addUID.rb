require 'yaml'
require 'securerandom'

yaml_hash = YAML.load_file('attendees.yml')
p yaml_hash['attendees']

yaml_hash['attendees'].each do |_letter, hash|
  p hash['name']
  p hash['email']
  p hash['attending']
  p hash['guid'] = SecureRandom.uuid if p hash['guid'] == nil
end

File.write('attendees.yml', yaml_hash.to_yaml)

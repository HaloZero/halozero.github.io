require 'json'

file_name = ARGV.shift
begin
  file = File.open(file_name)
rescue
  p "No File found #{file_name}"
  exit
end

slide_text = file.read()


config_file = File.open('config.json', 'r')
configuration = JSON.parse(config_file.read)

slide_text.gsub!('../../img', "#{configuration['directories']['images']}")

write_file = file_name ? File.open(file_name, 'w') : STDOUT

write_file.write(slide_text)
write_file.close

file.close

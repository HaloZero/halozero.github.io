require 'haml'

day_folders = Dir["source_slides/*"]
system 'rm -rf presentation_slides/*'
day_folders.each do |day_folder|
  new_folder_name = day_folder.gsub('source_slides', 'presentation_slides')
  system "mkdir #{new_folder_name}"
  system "cp -r #{day_folder}/* #{new_folder_name}"
  system "ruby haml-templater.rb template.haml #{new_folder_name}/index.html"
  system "ruby slide-imager-replace.rb #{new_folder_name}/slides.md"
end

template = File.read('main-file-template.haml')
haml_engine = Haml::Engine.new(template)

presentation_folders = day_folders.map { |folder|
  folder.gsub('source_slides', 'presentation_slides')
}
arguments = {directories: presentation_folders}
file = File.open('index.html', 'w')
file.write(haml_engine.render(Object.new, arguments))
file.close



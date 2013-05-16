maintainer       "Robostor"
maintainer_email "mail2ignis@gmail.com"
license          "All rights reserved"
description      "Installs/Configures naviserver"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

%w{ build-essential tcl runit }.each do |dep|
  depends dep
end

#!/usr/bin/env ruby
require_relative '../lib/pixel_term'

#Simple executable to run PixelTerm.

#Launches a new PixelTermInit instance with the default options.
PixelTerm::PixelTermInit.new


#PixelTerm::PixelTermInit.new(printer, command_line, min_image_size, max_image_size)
#Another example: PixelTerm::PixelTermInit.new(printer = CustomPrinter.new, command_line = CustomCommandLine.new(printer), 1, 150)


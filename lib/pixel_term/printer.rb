require 'set'

module PixelTerm

  # Simple class that contains strings and outputs data or information.
  # Methods that start with print_, print output to STDOUT.
  class Printer

    attr_writer :input_cursor

    def initialize(input_cursor = '>', output_cursor = '=>', debug = false)
      @input_cursor = input_cursor
      @output_cursor = output_cursor
      @debug = debug
    end

    def print_cursor
      print @input_cursor
    end

    def print_banner
      puts <<-eos
'||'''|,                    '||`    |''||''|
 ||   ||  ''                 ||        ||
 ||...|'  ||  \\  // .|'''|,  ||        ||    .|''|, '||''| '||),,(|,
 ||       ||    ><   ||..||  ||        ||    ||..||  ||     || || ||
.||      .||. //  \\ `|....  .||.      .||.   `|...  .||.   .||    ||.


PixelTerm version 0.1, Copyright (C) 2014 James Lopez
PixelTerm comes with ABSOLUTELY NO WARRANTY; for details
type see LICENSE.  This is free software, and you are welcome
to redistribute it under certain conditions;

      eos
    end

    def print_author
      puts 'by James Lopez <james@jameslopez.es>'
    end

    def print_first_help
      puts 'Type help and press enter for a list of commands.'
    end

    def print_not_found
      puts @output_cursor
      puts 'Command not found. Type help for help.'
    end

    def print_help
      puts @output_cursor
      puts <<-eos
#{'I'.bold} M N. Create a new M x N image with all pixels coloured white (O).
#{'C'.bold} Clears the table, setting all pixels to white (O).
#{'L'.bold} X Y C. Colours the pixel (X,Y) with colour C.
#{'V'.bold} X Y1 Y2 C. Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).
#{'H'.bold} X1 X2 Y C. Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).
#{'F'.bold} X Y C. Fill the region R with the colour C. R is defined as: Pixel (X,Y) belongs to R. Any other pixel which is the same colour as (X,Y) and shares a common side with any pixel in R also belongs to this region.
#{'S'.bold}. Show the contents of the current image
#{'X'.bold}. Terminate the session
      eos
    end

    def print_exception(e)
      puts "Error: #{e.message}".red
      puts e.backtrace if @debug
    end

    # @param [PixelImage] image
    # Prints an image such as:
    # OOOO
    # OOOO
    # OOOO
    def print_image(image)
      puts @output_cursor
      image.img.each do |r|
        puts r.map { |c| c }.join
      end
    end

    # BONUS hidden command.
    # @param [PixelImage] image
    # Prints an image such as:
    # OOOO
    # OOOO
    # OOOO
    # - using colours.
    def pretty_print_image(image)
      puts @output_cursor
      diff_pixels = image.img.flatten.uniq
      image.img.each do |r|
         r.each do |c|
          index = diff_pixels.index(c)
          print c.colour(index)
         end
        puts
      end
    end
  end
end

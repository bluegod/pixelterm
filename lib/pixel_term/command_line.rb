module PixelTerm

  #Command line utility
  class CommandLine

    def initialize(printer)
      @printer = printer || Printer.new
    end

    # Waits for input from STDIN
    def wait_for_input(min, max)
      #Stops the main loop that waits for input.
      #This could be an attr_writer of the class if we want to stop the app from other parts of the system.
      stop = false

      #Defines a new pixel image (array not created yet)
      begin
        @img = PixelImage.new(min, max)
      rescue => e
        @printer.print_exception(e)
        terminate('Error during initialisation. Exiting PixelTerm.')
      end

      #Exit gracefully on CTRL+C
      Kernel.trap('INT') {
        stop = true
        terminate('[CTRL+C pressed] Exiting PixelTerm.')
      }

      #Waits for input, while stop = false.
      while !stop
        @printer.print_cursor
        command = $stdin.gets.chomp.split
        #Generates a new command based on the first argument.
        begin
          Valid.command(command[0])
          cmd_name = "command_#{command[0].downcase}"
          if respond_to? cmd_name
            #Calls the command with the options passed in.
            send(cmd_name, command[1..-1])
          else
            @printer.print_not_found
          end
        rescue => e
          @printer.print_exception(e)
        end

      end
    end

    # List of commands
    # command_[key] where key = list of commands available.
    # see #printer.print_help

    def command_i(options)
      Valid.options_check(options, 2)
      #y,x
      x,y = Valid.get_numbers(options[0..1])
      @img = @img.create(x,y)
    end

    def command_help(options)
      @printer.print_help
    end

    def command_x(options)
      terminate
    end

    def command_c(options)
      Valid.img_exist(@img)
      @img.clear!
    end

    def command_s(options)
      Valid.img_exist(@img)
      @printer.print_image(@img)
    end

    def command_ss(options)
      Valid.img_exist(@img)
      @printer.pretty_print_image(@img)
    end

    def command_l (options)
      Valid.img_exist(@img)
      Valid.options_check(options, 3)
      x,y = Valid.get_numbers(options[0..1])
      @img.color_pixel(x, y, options[2])
    end

    def command_v (options)
      Valid.img_exist(@img)
      Valid.options_check(options, 4)
      x,y1, y2 = Valid.get_numbers(options[0..2])
      @img.color_segment_v(x, y1, y2, options[3])
    end

    def command_h (options)
      Valid.img_exist(@img)
      Valid.options_check(options, 4)
      x1,x2, y = Valid.get_numbers(options[0..2])
      @img.color_segment_h(x1, x2, y, options[3])
    end

    def command_f(options)
      Valid.img_exist(@img)
      Valid.options_check(options, 3)
      x,y = Valid.get_numbers(options[0..1])
      @img.fill_scanline_fast(x,y,options[2])
    end

    #Ends the program.
    def terminate(message = 'Thank you for using PixelTerm.')
      puts message
      exit
    end

  end
end
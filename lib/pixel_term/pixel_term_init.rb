module PixelTerm

  #Init class which runs the command line utility to wait for input on the command line.
  class PixelTermInit

    # Initialize, default values will be used if not provided.
    def initialize(printer = Printer.new, command_line = CommandLine.new(printer), min = 1, max = 150)
      system 'clear' or system 'cls'
      printer.print_banner
      printer.print_author
      printer.print_first_help
      command_line.wait_for_input(min,max)
    end
  end
end
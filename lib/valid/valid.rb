module Valid
  # Handy module that provides basic validation and error handling.
  # it may be resued in other classes.
  # i.e to separate validation logic related to commands or the image itself.

  def self.between(options, min, max)
    options.each do |n|
      if !n.between?(min, max)
        raise RangeError, "#{n} is not within the inclusive range: [#{min},#{max}]"
      end
    end
  end

  def self.get_numbers(string_values)
    string_values.map { |str| Integer(str, 10) }
  end

  def self.colour(colour)
    if colour !~ /^[A-Z]$/
      raise ArgumentError, "#{colour} is not a valid colour."
    end
  end

  def self.command(cmd)
    if cmd !~ /^(^[A-Z]$)|(^SS$)|(^help$)/
      raise ArgumentError, "#{cmd} is not a valid command."
    end
  end

  def self.options_check(options, expected_size)
    if options.length != expected_size
      raise ArgumentError, 'Invalid number of options provided.'
    end
  end

  def self.range(x, y, img_x, img_y)
    if x > img_x || y > img_y
      puts x.to_s + " " + img_x.to_s
      raise ArgumentError, 'Invalid options provided. Out of range.'
    end
  end

  def self.img_exist(img)
    if !img.exists?
      raise ArgumentError, 'An image does not exist.'
    end
  end

end
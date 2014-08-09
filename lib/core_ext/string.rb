# Extending String to output some colours
class String
  def red;     "\033[31m#{self}\033[0m" end
  def green;   "\033[32m#{self}\033[0m" end
  def brown;   "\033[33m#{self}\033[0m" end
  def blue;    "\033[34m#{self}\033[0m" end
  def magenta; "\033[35m#{self}\033[0m" end
  def cyan;    "\033[36m#{self}\033[0m" end
  def gray;    "\033[37m#{self}\033[0m" end
  def bold;    "\033[1m#{self}\033[22m" end

  # Returns the next colour
  # Ideally I should add some validation to protect from self-errors.
  def colour(key)
    colours = %w(green gray brown blue magenta cyan red)
    key = rand(colours.length-1) unless key < colours.length
    send(colours[key])
  end
end
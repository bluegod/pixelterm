module PixelTerm
  # Represents an image in a peculiar 2D space with the origin at the top-left
  # A point is define with the columns first: (y, x)
  # Contains points in the inclusive set:
  # M, N ∈ { [1,250] }, where M = columns and N = rows
  class PixelImage

    attr_reader :img

    def initialize(min, max)
      @min = min
      @max = max
    end

    def exists?
      !@img.nil?
    end

    #Create a new pixel image 2D array
    def create(x, y)
      Valid.between([x, y], @min, @max)
      @img = Array.new(y) { Array.new(x) { 'O' } }
      self
    end

    #Clears the image
    def clear!
      create(img_x, img_y)
    end

    #Colours one single pixel
    def color_pixel(x, y, colour)
      Valid.colour(colour)
      Valid.between([x, y], @min, @max)
      Valid.range(x, y, img_x, img_y)
      @img[y-1][x-1] = colour
    end

    def img_x
      @img.first.length
    end

    def img_y
      @img.length
    end

    #colours a segment vertically
    def color_segment_v(x, y1, y2, colour)
      segment = segment_check(colour, y1, y2, x, img_x, img_y)
      (segment.first..segment.last).each { |p| @img[p-1][x-1] = colour }
    end

    #colours a segment horizontally
    def color_segment_h(x1, x2, y, colour)
      segment = segment_check(colour, x1, x2, y, img_y, img_x)
      (segment.first..segment.last).each { |p| @img[y-1][p-1] = colour }
    end

    #Do some common validation
    def segment_check(colour, coord_1, coord_2, axis, max_axis, max_segment)
      Valid.colour(colour)
      Valid.between([axis], @min, max_axis)
      segment = [coord_1, coord_2].sort
      Valid.between(segment, @min, max_segment)
      segment
    end

    # I've based this method on:
    # http://en.wikipedia.org/wiki/Flood_fill#Scanline_fill
    # Seems the most efficient way as alternatives:
    # Recursion: Stack overflow problem
    # Pixel by pixel: at least 1 order of magnitude less efficient.
    #
    # PS I couldn't find any implementation of this in the internet.
    def fill_scanline_fast(x_coord, y_coord, newColour)
      Valid.colour(newColour)
      Valid.between([x_coord, y_coord], @min, @max)
      Valid.range(x_coord, y_coord, img_x, img_y)

      #Create a new stack to pop/push values up to a maximum value.
      stack = Stack.new
      y = x_coord - 1
      x = y_coord - 1
      stack.push([x, y])

      oldColour = @img[x][y]
      while (!stack.empty?)
        #Get the next value
        x,y = stack.pop
        y1 = y
        #Scan y1 to the left
        while (y1 >= 0 && @img[x][y1] == oldColour)
          y1-=1
        end

        y1+=1
        east, west = false, false

        #Fills in lines the neighbour pixels
        while (y1 < img_x && @img[x][y1] == oldColour)
          #Set new colour
          @img[x][y1] = newColour

          if (!east && x > 0 && @img[x - 1][y1] == oldColour)
            stack.push([x-1, y1])
            east = true
          elsif (east && x > 0 && @img[x - 1][y1] != oldColour)
            east = false
          end
          if (!west && x < img_y - 1 && @img[x + 1][y1] == oldColour)
            stack.push([x + 1, y1])
            west = true
          elsif (west && x < img_y - 1 && @img[x + 1][y1] != oldColour)
            west = false
          end
          y1+=1
        end
      end
    end
  end
end

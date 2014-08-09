module PixelTerm
#Basic stack structure - similar to array in Ruby but has a limit
#where it starts shifting elements. The alternative would be to
#stop there and output a warning (stack is full)
  class Stack

    include Enumerable

    def initialize(max = 1000)
      @size = max
      @queue = Array.new
    end

    def each(&blk)
      @queue.each(&blk)
    end

    def pop
      @queue.pop
    end

    def empty?
      @queue.empty?
    end

    #shifts if stack is full
    def push(value)
      @queue.shift if @queue.size >= @size
      @queue.push(value)
    end

    def to_a
      @queue.to_a
    end

    def <<(value)
      push(value)
    end

  end
end
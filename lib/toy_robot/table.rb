module ToyRobot
  class Table
    def initialize(width, length)
      @width = width
      @length = length
    end

    def valid_location?(north, east)
      (0...@width).cover?(east) &&
      (0...@length).cover?(north)
    end
  end
end

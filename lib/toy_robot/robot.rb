module ToyRobot
  class Robot
    DIRECTIONS = ["NORTH", "EAST", "SOUTH", "WEST"]

    attr_reader :east, :north, :direction

    def initialize(east = 0, north = 0, direction = "NORTH")
      @east = east
      @north = north
      @direction = direction
    end

    def move_east
      @east += 1
    end

    def move_west
      @east -= 1
    end

    def move_north
      @north += 1
    end

    def move_south
      @north -= 1
    end

    def move
      case @direction
        when "NORTH" then move_north
        when "SOUTH" then move_south
        when "EAST"  then move_east
        when "WEST"  then move_west
      end
    end

    def next_move
      case @direction
      when "NORTH"
        [@east, @north + 1]
      when "SOUTH"
        [@east, @north - 1]
      when "EAST"
        [@east + 1, @north]
      when "WEST"
        [@east - 1, @north]
      end
    end

    def turn_left
      turn(:left)
    end

    def turn_right
      turn(:right)
    end

    def report
      {
        north: @north,
        east: @east,
        direction: @direction
      }
    end

    private

    def turn(turn_direction)
      index = DIRECTIONS.index(@direction)
      rotations = turn_direction == :right ? 1 : -1
      @direction = DIRECTIONS.rotate(rotations)[index]
    end
  end
end

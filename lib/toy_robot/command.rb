module ToyRobot
  class Command
    def self.process(command)
      case command
      when /\APLACE (?<x>\d+),(?<y>\d+),(?<direction>\w+)\Z/
        [:place, $~[:x].to_i, $~[:y].to_i, $~[:direction]]
      when /\AMOVE\Z/
        [:move]
      when /\ALEFT\Z/
        [:turn_left]
      when /\ARIGHT\Z/
        [:turn_right]
      when /\AREPORT\Z/
        [:report]
      else
        [:invalid, command]
      end
    end
  end
end

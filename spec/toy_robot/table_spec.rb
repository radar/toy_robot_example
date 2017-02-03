require 'spec_helper'

describe ToyRobot::Table do
  subject { ToyRobot::Table.new(5, 5) }

  context "valid_location?" do
    it { should be_valid_location(0, 0) }
    it { should be_valid_location(4, 4) }
    it { should_not be_valid_location(5, 5) }
    it { should_not be_valid_location(-1, -1) }
  end
end

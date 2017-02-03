require "spec_helper"

describe ToyRobot::Simulator do
  let(:table) { ToyRobot::Table.new(5, 5) }
  subject { ToyRobot::Simulator.new(table) }

  it "places the robot onto a valid position" do
    expect(ToyRobot::Robot).to receive(:new)
      .with(0, 0, "NORTH")
      .and_return(double)
    subject.place(0, 0, "NORTH")
    expect(subject.robot).not_to be_nil
  end

  it "cannot place the robot onto an invalid position" do
    expect(ToyRobot::Robot).not_to receive(:new)
    subject.place(5, 5, "NORTH")
    expect(subject.robot).to be_nil
  end

  it "does not have the robot placed by default" do
    expect(subject.robot_placed?).to eq(false)
  end

  it "does not move the robot" do
    expect { subject.move }.to_not raise_error
  end

  it "turning an unplaced robot left does not cause an exception" do
    expect { subject.turn_left }.to_not raise_error
  end

  it "turning an unplaced robot right does not cause an exception" do
    expect { subject.turn_right }.to_not raise_error
  end

  it "asking an unplaced robot to report does not cause an exception" do
    expect { subject.turn_right }.to_not raise_error
  end

  it "informs us when a command is invalid" do
    message = "'PLACE 1, 2, NORTH' is an invalid command\n"
    expect { subject.invalid("PLACE 1, 2, NORTH") }.to output(message).to_stdout
  end

  context "when robot has been placed" do
    let(:robot) { instance_double(ToyRobot::Robot, next_move: [0, 0]) }
    before { allow(subject).to receive(:robot).and_return(robot) }

    it "tells the robot to move" do
      expect(robot).to receive(:move)
      subject.move
    end

    it "tells the robot to turn left" do
      expect(robot).to receive(:turn_left)
      subject.turn_left
    end

    it "tells the robot to turn right" do
      expect(robot).to receive(:turn_right)
      subject.turn_right
    end

    it "tells the robot to report" do
      expect(robot).to receive(:report) { { north: 3, east: 3, direction: "NORTH" }}
      message = "Robot is currently at (3, 3) and it's facing NORTH\n"
      expect { subject.report }.to output(message).to_stdout
    end

    it "has a placed robot" do
      expect(subject.robot_placed?).to eq(true)
    end
  end

  context "robot placed at table boundary" do
    before do
      subject.place(0, 4, "NORTH")
    end

    it "cannot move past the table boundary" do
      subject.move
      message = "Robot is currently at (0, 4) and it's facing NORTH\n"
      expect { subject.report }.to output(message).to_stdout
    end
  end
end

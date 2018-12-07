require "../../spec_helper"

module Day7_1
  describe "Day7-1" do
    it "example" do
      lines = File.read_lines("#{__DIR__}/example.txt")
      answer(lines).should eq "CABDFE"
    end

    it "input" do
      lines = File.read_lines("#{__DIR__}/input.txt")
      answer(lines).should eq File.read("#{__DIR__}/secret_answer").chomp
    end
  end
end

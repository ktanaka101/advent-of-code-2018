require "../../spec_helper"

module Day11_2
  describe "Day11-2" do
    it "example1" do
      lines = File.read_lines("#{__DIR__}/example1.txt")
      answer(lines).should eq "90,269,16"
    end

    it "example2" do
      lines = File.read_lines("#{__DIR__}/example2.txt")
      answer(lines).should eq "232,251,12"
    end

    it "input" do
      lines = File.read_lines("#{__DIR__}/input.txt")
      answer(lines).should eq File.read("#{__DIR__}/secret_answer").chomp
    end
  end
end

require "../../spec_helper"

module Day6_1
  describe "Day6-1" do
    it "example" do
      lines = File.read_lines("#{__DIR__}/example.txt")
      answer(lines).should eq 17
    end

    it "input" do
      lines = File.read_lines("#{__DIR__}/input.txt")
      answer(lines).should eq File.read("#{__DIR__}/secret_answer").to_i
    end
  end
end

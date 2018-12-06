require "../../spec_helper"

module Day6_2
  describe "Day6-2" do
    it "example" do
      lines = File.read_lines("#{__DIR__}/example.txt")
      answer(lines, 32).should eq 16
    end

    it "input" do
      lines = File.read_lines("#{__DIR__}/input.txt")
      answer(lines, 10000).should eq File.read("#{__DIR__}/secret_answer").to_i
    end
  end
end

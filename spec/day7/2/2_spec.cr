require "../../spec_helper"

module Day7_2
  describe "Day7-2" do
    it "example" do
      lines = File.read_lines("#{__DIR__}/example.txt")
      answer(lines, 2).should eq 258
    end

    it "input" do
      lines = File.read_lines("#{__DIR__}/input.txt")
      answer(lines, 5).should eq File.read("#{__DIR__}/secret_answer").to_i
    end
  end
end

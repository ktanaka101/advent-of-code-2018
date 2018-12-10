require "../../spec_helper"

module Day9_2
  describe "Day9-2" do
    it "input" do
      lines = File.read_lines("#{__DIR__}/input.txt")
      answer(lines).should eq File.read("#{__DIR__}/secret_answer").to_i64
    end
  end
end

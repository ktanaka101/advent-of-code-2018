require "../../spec_helper"

module Day5_2
  describe "Day5-2" do
    it "example" do
      lines = File.read_lines("#{__DIR__}/example.txt")
      answer(lines).should eq 4
    end

    it "input" do
      lines = File.read_lines("#{__DIR__}/input.txt")
      answer(lines).should eq File.read("#{__DIR__}/secret_answer").to_i
    end
  end
end

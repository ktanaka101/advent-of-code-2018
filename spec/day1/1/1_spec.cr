require "../../spec_helper"

module Day1_1
  describe "Day1-1" do
    it "example1" do
      lines = File.read_lines("#{__DIR__}/example1.txt")
      answer(lines).should eq 3
    end

    it "example2" do
      lines = File.read_lines("#{__DIR__}/example2.txt")
      answer(lines).should eq 0
    end

    it "example3" do
      lines = File.read_lines("#{__DIR__}/example3.txt")
      answer(lines).should eq -6
    end

    it "input" do
      lines = File.read_lines("#{__DIR__}/input.txt")
      answer(lines).should eq File.read("#{__DIR__}/secret_answer").to_i
    end
  end
end

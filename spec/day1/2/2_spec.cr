require "../../spec_helper"

module Day1_2
  describe "Day1-2" do
    it "example1" do
      lines = File.read_lines("#{__DIR__}/example1.txt")
      answer(lines).should eq 2
    end

    it "example2" do
      lines = File.read_lines("#{__DIR__}/example2.txt")
      answer(lines).should eq 0
    end

    it "example3" do
      lines = File.read_lines("#{__DIR__}/example3.txt")
      answer(lines).should eq 10
    end

    it "example4" do
      lines = File.read_lines("#{__DIR__}/example4.txt")
      answer(lines).should eq 5
    end

    it "example5" do
      lines = File.read_lines("#{__DIR__}/example5.txt")
      answer(lines).should eq 14
    end

    it "input" do
      lines = File.read_lines("#{__DIR__}/input.txt")
      answer(lines).should eq File.read("#{__DIR__}/secret_answer").to_i
    end
  end
end

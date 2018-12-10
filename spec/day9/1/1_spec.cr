require "../../spec_helper"

module Day9_1
  describe "Day9-1" do
    it "example1" do
      lines = File.read_lines("#{__DIR__}/example1.txt")
      answer(lines).should eq 8317
    end

    it "example2" do
      lines = File.read_lines("#{__DIR__}/example2.txt")
      answer(lines).should eq 146373
    end

    it "example3" do
      lines = File.read_lines("#{__DIR__}/example3.txt")
      answer(lines).should eq 2764
    end

    it "example4" do
      lines = File.read_lines("#{__DIR__}/example4.txt")
      answer(lines).should eq 54718
    end

    it "example5" do
      lines = File.read_lines("#{__DIR__}/example5.txt")
      answer(lines).should eq 37305
    end

    it "example6" do
      lines = File.read_lines("#{__DIR__}/example6.txt")
      answer(lines).should eq 32
    end

    it "input" do
      lines = File.read_lines("#{__DIR__}/input.txt")
      answer(lines).should eq File.read("#{__DIR__}/secret_answer").to_i
    end
  end
end

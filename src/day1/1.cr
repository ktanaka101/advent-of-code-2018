module Day1_1
  extend self

  def answer(lines : Array(String)) : Int32
    lines.map(&.to_i).sum
  end
end

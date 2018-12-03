module Day1_2
  extend self

  def answer(lines : Array(String)) : Int32
    current_frequency = 0
    memo = Set{current_frequency}
    frequencies = lines.map(&.to_i)

    frequencies.cycle do |frequency|
      current_frequency += frequency

      return current_frequency if memo.includes?(current_frequency)

      memo << current_frequency
    end
  end
end

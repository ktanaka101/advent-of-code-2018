module Day8_1
  extend self

  def answer(lines : Array(String)) : Int32
    ary = lines[0].split(/\s/).map(&.to_i)
    sum, _ = parser(ary, 0, 0)

    sum
  end

  def parser(input : Array(Int32), i : Int32, sum : Int32) : Tuple(Int32, Int32)
    child_node_num = input[i]
    i += 1
    meta_data_num = input[i]
    i += 1

    child_node_num.times do |_|
      sum, i = parser(input, i, sum)
    end

    meta_data_num.times do |j|
      sum += input[i]
      i += 1
    end

    return sum, i
  end
end

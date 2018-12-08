module Day8_2
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

    memo = [] of Int32

    child_node_num.times do |_|
      sum, i = parser(input, i, sum)
      memo << sum
    end

    if child_node_num == 0
      meta_data_num.times do |_|
        sum += input[i]
        i += 1
      end
    else
      meta_data_num.times do |_|
        res = memo[input[i] - 1]?
        sum += (res ? res : 0)
        i += 1
      end
    end

    return sum, i
  end
end

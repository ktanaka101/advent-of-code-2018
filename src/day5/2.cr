module Day5_2
  extend self

  def answer(lines : Array(String)) : Int32
    str = lines.first

    result_hs = {} of Char => Int32
    ('a'..'z').each do |delete_c|
      temp_str = str
      upper_c = delete_c.upcase
      down_c = delete_c
      temp_str = temp_str.delete(upper_c).delete(down_c)

      result_hs[delete_c] = same_remove(temp_str, 0).size
    end

    result_hs.min_by { |_, value| value }[1]
  end

  def same_remove(str : String, i : Int32) : String
    return str if i == (str.size - 1)

    c = str[i]
    comp_c = str[i + 1]

    return same_remove(str, i + 1) if c.lowercase? && comp_c.lowercase?
    return same_remove(str, i + 1) if c.uppercase? && comp_c.uppercase?
    return same_remove(str, i + 1) if c.downcase != comp_c.downcase
    return same_remove(str[0...i] + str[(i + 2)..-1], i == 0 ? 0 : i - 1)
  end
end

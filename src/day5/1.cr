module Day5_1
  extend self

  def answer(lines : Array(String)) : Int32
    str = lines.first

    same_remove(str, 0).size
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

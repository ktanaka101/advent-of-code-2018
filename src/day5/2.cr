module Day5_2
  extend self

  def answer(lines : Array(String)) : Int32
    str = lines.first

    ('a'..'z').to_a.zip(('A'..'Z').to_a).reduce(Int32::MAX) do |min_size, (down_case_delete_c, upcase_delete_c)|
      temp_str = str.delete { |c|
        {down_case_delete_c, upcase_delete_c}.includes?(c)
      }

      size = react_str(temp_str, 0).size
      size < min_size ? size : min_size
    end
  end

  def react_str(str : String, i : Int32) : String
    return str if i >= (str.size - 1)

    c = str[i]
    comp_c = str[i + 1]

    return react_str(str, i + 1) if c.lowercase? && comp_c.lowercase?
    return react_str(str, i + 1) if c.uppercase? && comp_c.uppercase?
    return react_str(str, i + 1) if c.downcase != comp_c.downcase

    react_str(str[0...i] + str[(i + 2)..-1], i == 0 ? 0 : i - 1)
  end
end

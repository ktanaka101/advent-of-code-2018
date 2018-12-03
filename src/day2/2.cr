module Day2_2
  extend self

  def answer(lines : Array(String)) : String
    lines.each_with_index do |line, i|
      lines[(i + 1)..-1].each do |comp_line|
        diff_count = 0

        line.each_char_with_index do |char, j|
          diff_count += 1 if line[j] != comp_line[j]
        end

        return remove_diff_first(line, comp_line) if diff_count == 1
      end
    end

    lines[-1]
  end

  def remove_diff_first(str1, str2) : String
    diff_char = nil
    arr1 = str1.split("")
    arr2 = str2.split("")
    arr3 = arr1

    arr1.each_with_index do |c, i|
      if c != arr2[i]
        arr3.delete_at(i)
        return arr3.join
      end
    end

    str1
  end
end

module Day2_1
  extend self

  def answer(lines : Array(String)) : Int32
    two_count = 0
    three_count = 0

    lines.each do |line|
      included_memo = Set(Char).new
      included_second = false
      included_third = false

      line.each_char do |char|
        unless included_memo.includes?(char)
          count = line.count(char)
          case count
          when 2
            unless included_second
              included_memo << char
              included_second = true
              two_count += 1
            end
          when 3
            unless included_third
              included_memo << char
              included_third = true
              three_count += 1
            end
          end

          break if included_second && included_third
        end
      end
    end

    two_count * three_count
  end
end

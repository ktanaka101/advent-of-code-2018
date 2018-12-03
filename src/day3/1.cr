module Day3_1
  extend self

  def answer(lines : Array(String)) : Int32
    fields = [Array(Bool?).new(1000, nil)]
    999.times do |i|
      fields.push(Array(Bool?).new(1000, nil))
    end

    lines.each do |line|
      match = /\A.+@\s(\d+),(\d+):\s(\d+)x(\d+)\z/.match(line)

      return 0 unless match

      x = match[1].to_i
      y = match[2].to_i
      width = match[3].to_i
      height = match[4].to_i

      (x...(x + width)).each do |i|
        (y...(y + height)).each do |j|
          case fields[i][j]
          when nil
            fields[i][j] = false
          when false
            fields[i][j] = true
          when true
            next
          end
        end
      end
    end

    fields.flatten.count { |field|
      field == true
    }
  end
end

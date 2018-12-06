module Day6_2
  extend self

  POS_FORMAT = /\A(\d+),\s(\d+)\z/

  def manhattan(x : Int32, y : Int32, o_x : Int32, o_y : Int32) : Int32
    (x - o_x).abs + (y - o_y).abs
  end

  def answer(lines : Array(String), max_border) : Int32
    positions = lines.map do |line|
      matched = POS_FORMAT.match(line).not_nil!
      {matched[1].to_i, matched[2].to_i}
    end

    max_x = positions.max_of { |pos| pos[0] }
    max_y = positions.max_of { |pos| pos[1] }

    safe_position_count = 0

    (0..max_x).each do |x|
      (0..max_y).each do |y|
        sum = positions.sum do |pos|
          range = manhattan(pos[0], pos[1], x, y)
          break max_border + 1 if range >= max_border
          range
        end

        safe_position_count += 1 if sum < max_border
      end
    end

    safe_position_count
  end
end

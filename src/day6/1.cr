module Day6_1
  extend self

  POS_FORMAT = /\A(\d+),\s(\d+)\z/

  def manhattan(x : Int32, y : Int32, o_x : Int32, o_y : Int32) : Int32
    (x - o_x).abs + (y - o_y).abs
  end

  def answer(lines : Array(String)) : Int32
    positions = lines.map_with_index do |line, id|
      matched = POS_FORMAT.match(line).not_nil!
      {matched[1].to_i, matched[2].to_i, id}
    end

    max_x = positions.max_of { |pos| pos[0] }
    max_y = positions.max_of { |pos| pos[1] }

    fields = Array.new(max_x + 1) do |arr|
      Array(Int32?).new(max_y + 1, nil)
    end

    fields = fields.map_with_index do |column, x|
      column.map_with_index do |cell, y|
        min_range = Int32::MAX
        min_id = -1
        is_duplicate = false

        positions.each do |pos|
          range = manhattan(pos[0], pos[1], x, y)
          case range
          when .< min_range
            min_range = range
            min_id = pos[2]
            is_duplicate = false
          when .== min_range
            is_duplicate = true
          end
        end

        if is_duplicate
          nil
        else
          min_id
        end
      end
    end

    around = fields[0] + fields[-1]
    around += fields.each_with_object([] of Int32?) do |column, arr|
      arr << column[0]
      arr << column[-1]
    end

    infinities = around.compact.to_set

    target = fields.flatten.compact.reject do |cell|
      infinities.includes?(cell)
    end

    target.group_by(&.itself).max_of { |_, v| v.size }
  end
end

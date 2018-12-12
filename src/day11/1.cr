module Day11_1
  extend self

  def answer(lines : Array(String))
    serial = lines.first.to_i

    grid = (1..300).map do |x|
      (1..300).map do |y|
        power_level(x, y, serial)
      end
    end

    max_sum = Int32::MIN
    max_x = nil
    max_y = nil

    300.times do |x|
      300.times do |y|
        sum = grid_sum(grid, x, y)
        if max_sum < sum
          max_sum = sum
          max_x = x
          max_y = y
        end
      end
    end

    "#{max_x},#{max_y}"
  end

  def grid_sum(grid, x, y)
    return 0 if x == 0 || y == 0 || x == 299 || y == 299
    sum = ((x - 1)..(x + 1)).sum do |x|
      ((y - 1)..(y + 1)).sum do |y|
        grid[x][y]
      end
    end
    sum
  end

  def power_level(x, y, serial) : Int32
    rack_id = x + 10
    power_level = ((rack_id * y + serial) * rack_id)
    power_level / 100 % 10 - 5
  end
end

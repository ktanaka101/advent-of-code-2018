module Day11_2
  extend self

  GRID_SIZE = 300

  def answer(lines : Array(String))
    serial = lines.first.to_i

    grid = (1..GRID_SIZE).map do |x|
      (1..GRID_SIZE).map do |y|
        power_level(x, y, serial)
      end
    end

    memo = Array.new(GRID_SIZE) do
      Array.new(GRID_SIZE) do
        Hash(Int32, Int32).new
      end
    end

    max_total_power = Int32::MIN
    max_x = -1
    max_y = -1
    max_size = -1

    (0...GRID_SIZE).reverse_each do |x|
      (0...GRID_SIZE).reverse_each do |y|
        (1..({GRID_SIZE - x, GRID_SIZE - y}.min)).each do |size|
          total_power = grid_sum(grid, x, y, size, memo)
          if total_power >= max_total_power
            max_total_power = total_power
            max_x = x
            max_y = y
            max_size = size
          end
        end
      end
    end

    "#{max_x + 1},#{max_y + 1},#{max_size}"
  end

  def grid_sum(grid, x, y, size, memo) : Int32
    memo_sum = if size != 1
                 memo[x + 1][y + 1][size - 1]?
               else
                 nil
               end

    if memo_sum
      sum = memo_sum
      sum += (x...(x + size)).sum { |_x| grid[_x][y] }
      sum += ((y + 1)...(y + size)).sum { |_y| grid[x][_y] }

      memo[x][y][size] = sum
    else
      sum = (x...(x + size)).sum do |_x|
        (y...(y + size)).sum do |_y|
          grid[_x][_y]
        end
      end

      memo[x][y][size] = sum
    end
  end

  def power_level(x, y, serial) : Int32
    rack_id = x + 10
    power_level = ((rack_id * y + serial) * rack_id)
    power_level / 100 % 10 - 5
  end
end

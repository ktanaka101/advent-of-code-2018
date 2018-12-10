module Day10_2
  extend self

  struct Star
    getter pos

    class Position
      property x, y

      def initialize(@x : Int32, @y : Int32)
      end
    end

    record Velocity, x : Int32, y : Int32

    def initialize(p_x : Int32, p_y : Int32, v_x : Int32, v_y : Int32)
      @pos = Position.new(p_x, p_y)
      @velocity = Velocity.new(v_x, v_y)
    end

    def advance(second)
      second.times { |_| update }
    end

    private def update
      @pos.x += @velocity.x
      @pos.y += @velocity.y
    end
  end

  RE = /\Aposition=<\s*(-?\d+),\s*(-?\d+)>\svelocity=<\s*(-?\d+),\s*(-?\d+)>\z/

  def answer(lines : Array(String))
    stars = lines.map do |line|
      matched = RE.match(line).not_nil!
      Star.new(matched[1].to_i, matched[2].to_i, matched[3].to_i, matched[4].to_i)
    end

    second = 1
    loop do
      stars.each(&.advance(1))

      if viewer(stars, 10)
        puts "at #{second} seconds"
        break
      end

      second += 1
    end
  end

  def viewer(stars : Array(Star), view_limit : Int32)
    min_x, max_x = stars.minmax_of(&.pos.x)
    min_y, max_y = stars.minmax_of(&.pos.y)

    return false if ((max_y - min_y) > view_limit)

    (min_y..max_y).each do |y|
      (min_x..max_x).each do |x|
        has_starlight = stars.any? { |star|
          star.pos.x == x && star.pos.y == y
        }
        print has_starlight ? "#" : "."
      end
      print "\n"
    end

    true
  end
end

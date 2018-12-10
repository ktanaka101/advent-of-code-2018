module Day9_2
  extend self

  RE = /\A(\d+)\splayers;\slast\smarble\sis\sworth\s(\d+)\spoints\z/

  class Node
    property! left : Node, right : Node
    getter value : Int64

    def initialize(@value : Int64)
      @left = self
      @right = self
    end

    def move(value) : Node
      case value
      when .< 0
        (value...0).reduce(self) { |node, _| node.left }
      when .> 0
        (0...value).reduce(self) { |node, _| node.right }
      else
        self
      end
    end

    def insert(value) : Node
      node = Node.new(value)
      node.left = self
      node.right = self.right
      self.right.left = node
      self.right = node
      node
    end

    def delete : Node
      self.left.right = self.right
      self.right.left = self.left
      self.right
    end
  end

  def answer(lines : Array(String))
    matched = RE.match(lines[0]).not_nil!
    player_num = matched[1].to_i
    end_marble_num = matched[2].to_i * 100

    players = Array(Int64).new(player_num, 0)
    marbles = Node.new(0)

    curr_player = 0
    last = (end_marble_num - end_marble_num % 23)

    (1_i64..last).each do |curr_marble|
      if curr_marble.divisible_by?(23)
        marbles = marbles.move(-7)
        players[curr_player] += curr_marble + marbles.value
        marbles = marbles.delete
      else
        marbles = marbles.move(1)
        marbles = marbles.insert(curr_marble)
      end
      curr_player = (curr_player + 1) % player_num
    end

    players.max
  end
end

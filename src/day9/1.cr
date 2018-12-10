module Day9_1
  extend self

  RE = /\A(\d+)\splayers;\slast\smarble\sis\sworth\s(\d+)\spoints\z/

  def answer(lines : Array(String))
    matched = RE.match(lines[0]).not_nil!
    player_num = matched[1].to_i
    end_marble_num = matched[2].to_i

    players = Array(Int32).new(player_num, 0)
    marbles = [0] of Int32

    curr_player = 0
    curr_pos = 1

    (1..end_marble_num).each do |curr_marble|
      if curr_marble.divisible_by?(23)
        curr_pos = (curr_pos - 7) % marbles.size
        players[curr_player] += curr_marble + marbles.delete_at(curr_pos)
      else
        curr_pos = (curr_pos + 2) % marbles.size
        marbles.insert(curr_pos, curr_marble)
      end
      curr_player = (curr_player + 1) % player_num
    end

    players.max
  end
end

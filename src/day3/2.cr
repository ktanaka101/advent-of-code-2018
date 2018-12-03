module Day3_2
  extend self

  def answer(lines : Array(String)) : Int32
    fields = [Array(Bool?).new(1000, nil)]
    999.times do |i|
      fields.push(Array(Bool?).new(1000, nil))
    end

    first_fields = [Array(Int32?).new(1000, nil)]
    999.times do |i|
      first_fields.push(Array(Int32?).new(1000, nil))
    end

    ids = {} of Int32 => Bool

    lines.each do |line|
      match = /\A#(\d+).+@\s(\d+),(\d+):\s(\d+)x(\d+)\z/.match(line)

      return 0 unless match

      id = match[1].to_i
      ids[id] = false
      x = match[2].to_i
      y = match[3].to_i
      width = match[4].to_i
      height = match[5].to_i

      (x...(x + width)).each do |i|
        (y...(y + height)).each do |j|
          case fields[i][j]
          when nil
            fields[i][j] = false
            first_fields[i][j] = id
          when false
            ids[id] = true
            first_id = first_fields[i][j]
            if first_id
              ids[first_id] = true
            end
            fields[i][j] = true
          when true
            ids[id] = true
            next
          end
        end
      end
    end

    ids.select { |id, duplicate| duplicate == false }.keys.first
  end
end

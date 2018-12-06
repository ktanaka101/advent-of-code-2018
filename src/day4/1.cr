module Day4_1
  extend self

  FORMAT       = /\[(\d{4}-\d{2}-\d{2}\s\d{2}:\d{2})\]\s(.*)/
  GUARD_FORMAT = /Guard #(\d+) begins shift/

  def answer(lines : Array(String)) : Int32
    sorted_lines = lines.sort_by do |line|
      matched = FORMAT.match(line)
      raise "#{line} not matched." unless matched
      Time.parse_utc(matched[1], "%F %H:%M")
    end

    hs = {} of Int32 => Int32
    begin_sleep_time = Time.now

    timeline = {} of Int32 => Array(Tuple(Time, Time))

    id = -1
    sorted_lines.each do |line|
      matched = FORMAT.match(line)
      raise "#{line} not matched.(#{FORMAT})" unless matched
      message = matched[2]
      case message
      when "falls asleep"
        begin_sleep_time = Time.parse_utc(matched[1], "%F %H:%M")
      when "wakes up"
        parse_time = Time.parse_utc(matched[1], "%F %H:%M")
        hs[id] += (parse_time - begin_sleep_time).total_minutes.to_i
        timeline[id] << {begin_sleep_time, parse_time}
      else
        guard = GUARD_FORMAT.match(message)
        raise "#{message} not matched.(#{GUARD_FORMAT})" unless guard
        id = guard[1].to_i
        hs[id] ||= 0
        timeline[id] ||= [] of Tuple(Time, Time)
      end
    end

    must_sleep_guard = hs.max_by { |_, value| value }

    counter = {} of Int32 => Int32

    timeline[must_sleep_guard[0]].each_with_index do |times, i|
      timeline[must_sleep_guard[0]][(i + 1)..-1].each do |comp_time|
        curr_comp_time = comp_time[0]
        while curr_comp_time < comp_time[1]
          if times[0].minute <= curr_comp_time.minute <= times[1].minute
            counter[curr_comp_time.minute] ||= 0
            counter[curr_comp_time.minute] += 1
          end
          curr_comp_time += Time::Span.new(0, 1, 0)
        end
      end
    end

    must_sleep_guard[0] * counter.max_by { |_, value| value }[0]
  end
end

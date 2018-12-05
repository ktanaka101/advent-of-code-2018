module Day4_2
  extend self

  FORMAT       = /\[(\d{4})-(\d{2})-(\d{2})\s(\d{2}):(\d{2})\]\s(.*)/
  GUARD_FORMAT = /Guard #(\d+) begins shift/

  def answer(lines : Array(String)) : Int32
    sorted_lines = lines.sort_by do |line|
      matched = FORMAT.match(line)
      next Time.now unless matched
      year = matched[1].to_i
      month = matched[2].to_i
      day = matched[3].to_i
      hour = matched[4].to_i
      minute = matched[5].to_i
      Time.new(year, month, day, hour, minute, 0)
    end

    hs = {} of Int32 => Int32
    begin_sleep_time = Time.now

    timelines = {} of Int32 => Array(Tuple(Time, Time))

    id = -1
    sorted_lines.each do |line|
      matched = FORMAT.match(line)
      raise "#{line} not matched.(#{FORMAT})" unless matched
      message = matched[6]
      case message
      when "falls asleep"
        year = matched[1].to_i
        month = matched[2].to_i
        day = matched[3].to_i
        hour = matched[4].to_i
        minute = matched[5].to_i

        begin_sleep_time = Time.new(year, month, day, hour, minute, 0)
      when "wakes up"
        year = matched[1].to_i
        month = matched[2].to_i
        day = matched[3].to_i
        hour = matched[4].to_i
        minute = matched[5].to_i

        hs[id] += (Time.new(year, month, day, hour, minute, 0) - begin_sleep_time).total_minutes.to_i
        timelines[id] << {begin_sleep_time, Time.new(year, month, day, hour, minute, 0)}
      else
        guard = GUARD_FORMAT.match(message)
        raise "#{message} not matched.(#{GUARD_FORMAT})" unless guard
        id = guard[1].to_i
        hs[id] ||= 0
        timelines[id] ||= [] of Tuple(Time, Time)
      end
    end

    must_sleep_guard = hs.max_by do |key, value|
      value
    end

    counter = {} of Int32 => Hash(Int32, Int32)

    timelines.each do |id, timeline|
      timeline.each_with_index do |times, i|
        timeline[(i + 1)..-1].each do |comp_time|
          curr_comp_time = comp_time[0]
          while curr_comp_time < comp_time[1]
            if times[0].minute <= curr_comp_time.minute <= times[1].minute
              counter[id] ||= {} of Int32 => Int32
              counter[id][curr_comp_time.minute] ||= 0
              counter[id][curr_comp_time.minute] += 1
            end
            curr_comp_time += Time::Span.new(0, 1, 0)
          end
        end
      end
    end

    max_id = -1
    max_minute = -1
    max_count = -1

    counter.each do |id, times|
      times.each do |minute, count|
        if count > max_count
          max_id = id
          max_minute = minute
          max_count = count
        end
      end
    end

    max_id * max_minute
  end
end

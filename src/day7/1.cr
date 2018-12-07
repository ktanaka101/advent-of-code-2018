module Day7_1
  extend self

  RE = /Step\s([A-Z])\smust\sbe\sfinished\sbefore\sstep\s([A-Z])\scan\sbegin./

  class Step
    getter name, next_steps, depend_steps

    def initialize(@name : Char)
      @next_steps = [] of Step
      @depend_steps = [] of Step
    end

    def add_next_step(step : Step)
      @next_steps << step
    end

    def add_depend_step(step : Step)
      @depend_steps << step
    end

    def executable?(executed_steps : Array(Step)) : Bool
      @depend_steps.all? { |depend_step|
        executed_steps.includes?(depend_step)
      }
    end

    def inspect
      @name
    end

    def_equals @name
  end

  def ordered_steps(steps : Array(Step)) : Array(Step)
    executable_steps = steps.select { |step| step.depend_steps.empty? }
    return [] of Step if executable_steps.empty?
    exec_first_step = executable_steps.sort_by!(&.name).shift

    executed_steps = [exec_first_step] of Step
    planed_exec_steps = executable_steps.concat(exec_first_step.next_steps).uniq!.sort_by!(&.name)

    while !planed_exec_steps.empty?
      exec_step = planed_exec_steps.find(&.executable?(executed_steps))
      raise "Unable to resolve dependencies." unless exec_step

      planed_exec_steps.delete(exec_step)
      executed_steps << exec_step

      planed_exec_steps.concat(exec_step.next_steps).uniq!.sort_by!(&.name) unless exec_step.next_steps.empty?
    end

    executed_steps
  end

  def answer(lines : Array(String)) : String
    steps = lines.each_with_object({} of Char => Step) do |line, steps|
      matched = RE.match(line).not_nil!
      step_c = matched[1][0]
      next_step_c = matched[2][0]

      step = steps[step_c]?
      if step.nil?
        step = Step.new(step_c)
        steps[step_c] = step
      end

      next_step = steps[next_step_c]?
      if next_step.nil?
        next_step = Step.new(next_step_c)
        steps[next_step_c] = next_step
      end

      next_step.add_depend_step(step)
      step.add_next_step(next_step)
    end.values

    ordered_steps(steps).map(&.name).join
  end
end

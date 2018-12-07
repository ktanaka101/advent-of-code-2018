module Day7_2
  extend self

  RE = /Step\s([A-Z])\smust\sbe\sfinished\sbefore\sstep\s([A-Z])\scan\sbegin./

  class Step
    getter name, next_steps, depend_steps

    def initialize(@name : Char)
      @working_sec = (@name - '@' + 60).as Int32
      @working_progress = 0
      @next_steps = [] of Step
      @depend_steps = [] of Step
      @is_completed = false
    end

    def work!
      unless @is_completed
        @working_progress += 1
        @is_completed = true if @working_progress == @working_sec
      end
    end

    def complete?
      @is_completed
    end

    def add_next_step(step : Step)
      @next_steps << step
    end

    def add_depend_step(step : Step)
      @depend_steps << step
    end

    def executable? : Bool
      @depend_steps.all?(&.complete?)
    end

    def inspect
      @name
    end

    def_equals @name
  end

  def calc_exec_steps_time(steps : Array(Step), job_limit : Int32) : Int32
    planed_exec_steps = steps.uniq!.select { |step| step.depend_steps.empty? }.sort_by!(&.name)
    executing_steps = [] of Step

    timer = -1

    while !planed_exec_steps.empty? || !executing_steps.empty?
      timer += 1

      # update executing steps
      executing_steps.each(&.work!)

      # remove executing steps of complete
      executing_steps.reject!(&.complete?)

      # add executing steps
      while executing_steps.size < job_limit
        exec_step = planed_exec_steps.find(&.executable?)
        break if exec_step.nil?

        executing_steps << exec_step
        planed_exec_steps.delete(exec_step)
        planed_exec_steps.concat(exec_step.next_steps).uniq!.sort_by!(&.name) unless exec_step.next_steps.empty?
      end
    end

    timer
  end

  def answer(lines : Array(String), job_limit : Int32) : Int32
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

    calc_exec_steps_time(steps, job_limit)
  end
end

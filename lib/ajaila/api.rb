module Ajaila
  self.extend Ajaila

  def to_growth(p1,p2)
    p1, p2 = p1.to_f, p2.to_f
    return (p1 != 0 and p2 != 0)? p2/p1 - 1 : 0
  end

  ##
  # Normalize array
  def normalize(array)
    min, max = array.min, array.max
    more = lambda { |a| d = 1/(max-min).to_f; a.map { |el| (el-min)*d } }
    return min < max ? more.call(array) : array.fill(1.0)
  end

  def detect_nil(input, quit = 0)
    raise "Ajaila: Found Nil value among input values." if input == nil and quit == 0
    return input if input != nil
    return 0.0 if input == nil && (quit == 1 or quit == :quit)
  end

  def execute_miner(name)
    system "ajaila run miner #{name}"
  end

  def execute_selector(name)
    system "ajaila run selector #{name}"
  end

  def all_days_at_interval(time_start, time_end)
    output = []
    while time_start < time_end
      output << time_start
      time_start = time_start + 60 * 60 * 24
    end
    return output
  end

  def one_day
    return 60 * 60 * 24
  end

end
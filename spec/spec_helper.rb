require 'capybara/rspec'

class Stopwatch

  def initialize()
    @start = Time.now
  end

  def elapsed_time
    now = Time.now
    elapsed_time = now - @start
    elapsed_time
  end

end

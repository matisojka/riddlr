class Expectation
  attr_reader :title, :code, :message, :backtrace

  def self.from_hash(hash)
    self.new(hash['title'], hash['code'])
  end

  def initialize(title, code)
    @title = title
    @code = code
    @passed = passed
  end

  def passed?
    @passed
  end

  def failed(message, backtrace)
    @message = message
    @backtrace = backtrace
    @passed = false
  end

  def passed!
    @passed = true
  end
end

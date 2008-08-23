class Buffer
  attr_reader :read

  def initialize
    @read = ""
  end

  def puts(text)
    @read << text << "\n"
  end
end

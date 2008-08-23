require 'builder'

class Buffer
  attr_reader :read

  def initialize
    @read = ""
  end

  def puts(text)
    @read << text << "\n"
  end

  def html
    xml = Builder::XmlMarkup.new
    yield xml
    @read << xml.target!
  end

end

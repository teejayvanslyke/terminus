class Application < Merb::Controller
  before :assign_buffer

  def assign_buffer
    @buffer = Buffer.new
  end

end

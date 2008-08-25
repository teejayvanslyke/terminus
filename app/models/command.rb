$COMMANDS = {}

class Command < ActiveRecord::Base
  attr_reader :buffer 

  def command_url(command, args=[])
    '#'+command
  end

  def self.load_native(dir)
    Dir["#{dir}/*.rb"].each {|file| require file}
  end

end

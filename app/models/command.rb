$COMMANDS = {}

class Command < ActiveRecord::Base
  attr_reader :buffer 

  def initialize(buffer)
    @buffer = buffer 
  end

  def command_url(command, args=[])
    '#'+command
  end

  def self.name(name)
    puts " ~ loading command '#{name}'"
    $COMMANDS[name] = self
  end

  def self.load_native(dir)
    Dir["#{dir}/*.rb"].each {|file| require file}
  end

end

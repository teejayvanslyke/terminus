class Commands < Application
  layout :none
  # provides :xml, :yaml, :js

  def index
    @commands = Command.find(:all)
    display @commands
  end

  def show
    klass = $COMMANDS[params[:id]]
    args  = params['args'] || []
    if klass
      @command = klass.new(@buffer)
      @command.execute(args)
    else
      @buffer.puts "Oops!  I don't know the command #{params[:id]}"
    end
    render
  end

  def new
    only_provides :html
    @command = Command.new({:code => 
      "command \"my-command\" do |*args|\n  puts Hello, World!\nend"})
    render
  end

  def create
    @command = Command.new(params[:command])
    if @command.save
      redirect url(:command, @command)
    else
      render :new
    end
  end

  def edit
    only_provides :html
    @command = Command.find_by_id(params[:id])
    raise NotFound unless @command
    render
  end

  def update
    @command = Command.find_by_id(params[:id])
    raise NotFound unless @command
    if @command.update_attributes(params[:command])
      redirect url(:command, @command)
    else
      raise BadRequest
    end
  end

  def destroy
    @command = Command.find_by_id(params[:id])
    raise NotFound unless @command
    if @command.destroy
      redirect url(:commands)
    else
      raise BadRequest
    end
  end

end

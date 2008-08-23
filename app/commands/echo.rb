class Echo < Command
  name "echo"

  def execute(args)
    if args.empty?
      buffer.puts 'usage: echo "some string"'
      return
    end

    args.each do |arg|
      buffer.puts arg
    end
  end

end

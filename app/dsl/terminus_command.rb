module Terminus
  module DSL
    def terminus_command(name, &block)
      command = NativeCommand.new(name)
      command.instance_eval(&block)
      $COMMANDS[name] = command
      puts " ~ loading native command '#{name}'"
    end

    class OnExecute
      attr_reader :response
      attr_reader :args

      def initialize(command, &block)
        @command = command
        @block   = block
        @args    = []
      end

      def eval(args)
        @args = args
        @command.instance_eval(&@block)
        @response = @command.response
      end

    end

    class RespondTo
      def initialize(parent)
        @parent = parent
        @builder = Builder::XmlMarkup.new
      end

      def args; @parent.args || []; end

      def response; @builder.target!; end

      def image(url)
        @builder.img(:src => url)
      end

      def line(*args)
        @builder.p do
          args.each do |arg| 
            if arg.is_a? String
              @builder.text! arg
            end
          end
        end
      end

      def newline
        @builder.br
      end
    end

    class NativeCommand < Command

      attr_reader :response

      def args
        return [] unless @on_execute
        @on_execute.args
      end
      
      def execute(args, buffer)
        @on_execute.eval(args)
        buffer.puts(@on_execute.response)
      end

      def respond_to(&block)
        respond_to = RespondTo.new(self)
        respond_to.instance_eval(&block)
        @response = respond_to.response
      end


      def on_execute(&block)
        @on_execute = OnExecute.new(self, &block)
      end

    end
  end
end


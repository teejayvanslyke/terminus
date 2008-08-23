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

      def initialize(command, &block)
        @command = command
        @block   = block
      end

      def eval
        self.instance_eval(&@block)
      end

      def respond_with(&block)
        respond_with = RespondWith.new(self)
        respond_with.instance_eval(&block)
        @response = respond_with.response
      end
    end

    class RespondWith
      def initialize(parent)
        @parent = parent
        @builder = Builder::XmlMarkup.new
      end

      def response; @builder.target!; end

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
      
      def execute(args, buffer)
        @on_execute.eval
        buffer.puts(@on_execute.response)
      end

      def on_execute(&block)
        @on_execute = OnExecute.new(self, &block)
      end

    end
  end
end


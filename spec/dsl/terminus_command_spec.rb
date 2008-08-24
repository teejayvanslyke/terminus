require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

include Terminus::DSL

describe Terminus::DSL do

  describe "terminus_command" do
    it "creates a new command instance" do
      NativeCommand.should_receive(:new).with('mycommand')
      terminus_command('mycommand') { }
    end
  end

  describe NativeCommand do

    before(:each) do
      NativeCommand.class_eval    { def variable; @variable; end }
      @command = NativeCommand.new(@buffer)
      @buffer  = stub(:buffer)

      @buffer.stub!(:puts)

      @command.instance_eval { @variable = true }
      @command.on_execute { @variable = args[0] }
    end

    describe "execute" do
      it "executes the on_execute block with the given arguments" do
        @command.variable.should be_true
        @command.execute([false], @buffer)
        @command.variable.should be_false
      end
    end
  
  end

  describe RespondTo do

    before(:each) do
      @buffer  = stub(:buffer)
      @buffer.stub!(:puts)

      terminus_command 'mycommand' do
        on_execute do 
          respond_to do
            line args[0]
          end
        end
      end

      @respond_to = RespondTo.new($COMMANDS['mycommand'])
      RespondTo.stub!(:new).and_return(@respond_to)
    end

    it "creates a RespondTo instance" do
      RespondTo.should_receive(:new).and_return(@respond_to)
      $COMMANDS['mycommand'].execute(['test'], @buffer)
    end

    it "executes the command(s) in the block" do
      @respond_to.should_receive(:line).with('test')
      $COMMANDS['mycommand'].execute(['test'], @buffer)
    end

    it "sets up the response" do
      $COMMANDS['mycommand'].execute(['test'], @buffer)
      $COMMANDS['mycommand'].response.should == '<p>test</p>'
    end

  end

end

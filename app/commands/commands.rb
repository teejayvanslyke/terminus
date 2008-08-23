include Terminus::DSL

terminus_command 'commands' do

  on_execute do |args|
    respond_with do
      line "Built-in commands:"
      newline
      $COMMANDS.each_key do |cmd|
        line cmd 
      end
    end
  end

end




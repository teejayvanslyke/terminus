include Terminus::DSL

terminus_command 'commands' do

  on_execute do 
    respond_to do
      line "Built-in commands:"
      $COMMANDS.each_key do |cmd|
        line cmd 
      end
    end
  end

end




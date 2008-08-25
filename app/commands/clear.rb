include Terminus::DSL

terminus_command 'clear' do

  on_execute do 
    respond_to do
      js "terminal.clear();"
    end
  end

end




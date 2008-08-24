include Terminus::DSL

terminus_command 'echo' do

  on_execute do 
    respond_to do
      args.each do |arg|
        line arg
      end
    end
  end

end




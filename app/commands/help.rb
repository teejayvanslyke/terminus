include Terminus::DSL

terminus_command 'help' do

  on_execute do |args|
    respond_with do
      line "Welcome to t.ermin.us."
      line "Put simply, t.ermin.us makes the command line fun again."
      line "To get started, type 'commands'."
    end
  end

end




include Terminus::DSL

terminus_command 'about' do

  on_execute do 
    respond_to do
      image "/images/logo.png"
      line "Version #{Terminus::VERSION}"
    end
  end

end




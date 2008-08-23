include Terminus::DSL

terminus_command 'about' do

  on_execute do |args|
    respond_with do
      image "/images/logo.png"
      line "Version #{Terminus::VERSION}"
    end
  end

end




module Merb
  module CommandsHelper

    def image_submit(src, html_options={})
      tag :input, html_options.merge(:type => 'image', :src => '/images/'+src)
    end

  end
end # Merb

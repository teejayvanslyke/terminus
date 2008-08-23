gem 'rflickr'
require 'flickr'

module Terminus
  class FlickrCommand < Command
    name 'flickr'

    FLICKR_API_KEY        = '882b3e5350d5bf8cc61a76c12e4a395f'
    FLICKR_SHARED_SECRET  = '7891ad495bdd8829'

    def execute(args)
      flickr = Flickr.new('/tmp/flickr.cache', FLICKR_API_KEY, FLICKR_SHARED_SECRET)
      unless flickr.auth.token
        flickr.auth.getFrob
        url = flickr.auth.login_link
        puts "You must visit #{url} to authorize this application.  Press enter"+
         " when you have done so. This is the only time you will have to do this."
        gets
        flickr.auth.getToken
        flickr.auth.cache_token
      end
      photos = flickr.photos.search(nil, nil, nil, args[0])
      photos.each do |photo|
        buffer.html '<img src="' + photo.url('s') + '"/>'
      end
    rescue XMLRPC::FaultException
      buffer.puts "There was an error connecting to Flickr."
    end

  end
end

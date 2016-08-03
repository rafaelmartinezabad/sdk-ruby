require 'rubygems'
require 'bundler/setup'

require '../lib/NimbleAPI.rb'

class GetOtpUrl

  def method( ticket, back_url )
    # back_url is a url redirection callback in string format
    # Example: "http://my-ecommerce.com/return"
    # include commas
    return NimbleAPI.getOtpUrl( ticket, back_url )
  end

end
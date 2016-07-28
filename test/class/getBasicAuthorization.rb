require 'rubygems'
require 'bundler/setup'

require '../lib/NimbleAPI.rb'

class GetBasicAuthorization

  def method( cc )
    return NimbleAPI::Auth.new( cc.clientId, cc.clientSecret ).getBasicAuthorization
  end

end
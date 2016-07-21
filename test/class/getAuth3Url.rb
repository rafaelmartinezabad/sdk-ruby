require 'rubygems'
require 'bundler/setup'

require '../lib/NimbleAPI.rb'

class GetAuth3Url

  def getAuth3Url( oNimbleAPI )
    return oNimbleAPI.getAuth3Url
  end

end
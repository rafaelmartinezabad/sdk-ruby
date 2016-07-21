require 'rubygems'
require 'bundler/setup'

require '../lib/NimbleAPI.rb'

class Check

  def check( oNimbleAPI )
    return NimbleAPI::Credentials.new.check( oNimbleAPI )
  end

end
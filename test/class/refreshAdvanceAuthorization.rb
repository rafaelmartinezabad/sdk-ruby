require 'rubygems'
require 'bundler/setup'

require '../lib/NimbleAPI.rb'

class RefreshAdvanceAuthorization

  def method( cc, refresh_token )
    return NimbleAPI::Auth.new( cc.clientId, cc.clientSecret ).refreshAdvanceAuthorization( refresh_token )
  end

end
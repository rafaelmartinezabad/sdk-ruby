require 'rubygems'
require 'bundler/setup'

require '../lib/NimbleAPI.rb'

class GetStatusByTransactionId

  def getStatusByTransactionId( oNimbleAPI )
    transactionId = 1000002108
    return NimbleAPI::Payments.new.getStatusByTransactionId( oNimbleAPI, transactionId )
  end

end

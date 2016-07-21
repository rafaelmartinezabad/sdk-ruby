require 'rubygems'
require 'bundler/setup'

require '../lib/NimbleAPI.rb'

class SendPayment

  def sendPayment( oNimbleAPI )
    oPayment = {
      'amount' => 100,
      'currency' => "EUR",
      'paymentSuccessUrl' => "http://www.google.es/&q=EXITO",
      'paymentErrorUrl' => "http://www.google.es/&q=ERROR",
      'merchantOrderId' => 1234,
    }
    return NimbleAPI::Payments.new.sendPayment( oNimbleAPI, oPayment )
  end

end

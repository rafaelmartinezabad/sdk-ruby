require 'rubygems'
require 'bundler/setup'

require '../lib/NimbleAPI.rb'

class SendPayment

  def method( cc )
    oNimbleAPI = NimbleAPI.new(
      cc.clientId,
      cc.clientSecret,
      cc.sandbox
    )
    oNimbleAPI.changeDefaultLanguage('es') #Optional
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

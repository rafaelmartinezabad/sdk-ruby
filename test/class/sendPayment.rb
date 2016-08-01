require 'rubygems'
require 'bundler/setup'

require '../lib/NimbleAPI.rb'

class SendPayment

  def method( cc, paymentUrl )
    oNimbleAPI = NimbleAPI.new(
      cc.clientId,
      cc.clientSecret,
      cc.sandbox
    )
    oNimbleAPI.changeDefaultLanguage('es') #Optional
    # paymentUrl is a url redirection callback in string format
    # Example paymentSuccessUrl: "http://my-ecommerce.com/correct"
    # Example paymentErrorUrl: "http://my-ecommerce.com/error"
    # include commas
    oPayment = {
      'amount' => 1000,
      'currency' => "EUR",
      'paymentSuccessUrl' => "#{paymentUrl}?responsePayment=CORRECT",
      'paymentErrorUrl' => "#{paymentUrl}?responsePayment=ERROR",
      'merchantOrderId' => "test-merchant-id",
    }
    return NimbleAPI::Payments.new.sendPayment( oNimbleAPI, oPayment )
  end

end

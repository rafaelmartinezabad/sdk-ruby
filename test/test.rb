require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'httparty'
require 'json'
require 'byebug' if development?

require '../lib/NimbleAPI.rb'

class Test < Sinatra::Base

  get '/' do
    sandbox = false
    oNimbleAPI = NimbleAPI.new(
      '729DFCD7A2B4643A0DA3D4A7E537FC6E',
      'jg26cI3O1mB0$eR&fo6a2TWPmq&gyQoUOG6tClO%VE*N$SN9xX27@R4CTqi*$4EO',
      sandbox
    )
    oPayment = {
        'amount' => 100,
        'currency' => "EUR",
        'paymentSuccessUrl' => "http://www.google.es/&q=EXITO",
        'paymentErrorUrl' => "http://www.google.es/&q=ERROR",
        'merchantOrderId' => 1234,
      }
    erb :index, :locals => {
      oSendPay: NimbleAPI::Payments.new.sendPayment( oNimbleAPI, oPayment )
    }
  end

  run! if app_file == $0

end

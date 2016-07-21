require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'httparty'
require 'json'
require 'byebug' if development?

require '../lib/NimbleAPI.rb'

require './class/sendPayment.rb'
require './class/getStatusByTransactionId.rb'
require './class/getStatusByMerchantOrderId.rb'
require './class/check.rb'
require './class/updateMerchantOrderId.rb'
require './class/getAuth3Url.rb'
require './class/getAdvanceAuthorization.rb'

class Index < Sinatra::Base

  def oNimbleAPI
    sandbox = false
    oNimbleAPI = NimbleAPI.new(
      '729DFCD7A2B4643A0DA3D4A7E537FC6E',
      'jg26cI3O1mB0$eR&fo6a2TWPmq&gyQoUOG6tClO%VE*N$SN9xX27@R4CTqi*$4EO',
      sandbox
    )
    return oNimbleAPI
  end

  get '/' do
    erb :index, :locals => {
      obj_res: oNimbleAPI,
      valid: Check.new.check( oNimbleAPI )['result']['code']
    }
  end

  get '/sendPayment' do
    erb :sendPayment, :locals => {
      obj_res: SendPayment.new.sendPayment( oNimbleAPI )
    }
  end

  get '/getStatusByTransactionId' do
    erb :getStatusByTransactionId, :locals => {
      obj_res: GetStatusByTransactionId.new.getStatusByTransactionId( oNimbleAPI )
    }
  end

  get '/getStatusByMerchantOrderId' do
    erb :getStatusByMerchantOrderId, :locals => {
      obj_res: GetStatusByMerchantOrderId.new.getStatusByMerchantOrderId( oNimbleAPI )
    }
  end

  get '/check' do
    erb :check, :locals => {
      obj_res: Check.new.check( oNimbleAPI )
    }
  end

  get '/updateMerchantOrderId' do
    erb :updateMerchantOrderId, :locals => {
      obj_res: UpdateMerchantOrderId.new.updateMerchantOrderId( oNimbleAPI )
    }
  end

  get '/getAuth3Url' do
    erb :getAuth3Url, :locals => {
      obj_res: GetAuth3Url.new.getAuth3Url( oNimbleAPI )
    }
  end

  get '/getAdvanceAuthorization' do
    code = request.env['QUERY_STRING'].to_s.gsub('code=', '')
    if code != ""
      erb :getAdvanceAuthorization, :locals => {
        obj_res: GetAdvanceAuthorization.new.getAdvanceAuthorization( oNimbleAPI, code )
      }
    else
      redirect "/"
    end
  end

  run! if app_file == $0

end

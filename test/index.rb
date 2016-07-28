require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'httparty'
require 'json'

require '../lib/NimbleAPI.rb'
Dir["./class/*.rb"].each {|file| require file }

class Index < Sinatra::Base

  enable :sessions

  get '/' do
    erb :index
  end

  get '/sendPayment' do
    erb :sendPayment, :locals => {
      obj_res: SendPayment.new.method( ClientCredentials.new )
    }
  end

  get '/getStatusByTransactionId' do
    transactionId = request.params['transactionId']
    res_obj = nil
    if transactionId != nil && transactionId != ""
      res_obj = GetStatusByTransactionId.new.method( ClientCredentials.new, transactionId )
    end
    erb :getStatusByTransactionId, :locals => {
      obj_res: res_obj
    }
  end

  get '/getStatusByMerchantOrderId' do
    merchantOrderId = request.params['merchantOrderId']
    res_obj = nil
    if merchantOrderId != nil && merchantOrderId != ""
      res_obj = GetStatusByMerchantOrderId.new.method( ClientCredentials.new, merchantOrderId )
    end
    erb :getStatusByMerchantOrderId, :locals => {
      obj_res: res_obj
    }
  end

  get '/check' do
    cc = ClientCredentials.new
    erb :check, :locals => {
      cc: cc, obj_res: Check.new.method( cc )
    }
  end

  get '/updateMerchantOrderId' do
    transactionId = request.params['transactionId']
    merchantOrderId = request.params['merchantOrderId']
    if transactionId != nil && transactionId != "" && merchantOrderId != nil && merchantOrderId != ""
      res_obj = UpdateMerchantOrderId.new.method( ClientCredentials.new, transactionId, merchantOrderId )
    end
    erb :updateMerchantOrderId, :locals => {
      obj_res: res_obj
    }
  end

  get '/getBasicAuthorization' do
    erb :getBasicAuthorization, :locals => {
      obj_res: GetBasicAuthorization.new.method( ClientCredentials.new )
    }
  end

  get '/getAdvanceAuthorization' do
    code = request.params['code']
    if code == nil
      res_obj = GetAuth3Url.new.method( ClientCredentials.new )
    else
      res_obj = GetAdvanceAuthorization.new.method( ClientCredentials.new, code )
      if res_obj['access_token'] == "" || res_obj['refresh_token'] == ""
        code = nil
        res_obj = GetAuth3Url.new.method( ClientCredentials.new )
      end
    end
    erb :getAdvanceAuthorization, :locals => {
      code: code != nil, obj_res: res_obj
    }
  end

  get '/refreshAdvanceAuthorization' do
    refresh_token = request.params['refresh_token']
    res_obj = nil
    if refresh_token != nil
      res_obj = RefreshAdvanceAuthorization.new.method( ClientCredentials.new, refresh_token )
    end
    erb :refreshAdvanceAuthorization, :locals => {
      obj_res: res_obj
    }
  end

  get '/balance' do
    access_token = request.params['access_token']
    res_obj = nil
    if access_token != nil
      res_obj = Balance.new.method( ClientCredentials.new, access_token )
    end
    erb :balance, :locals => {
      obj_res: res_obj
    }
  end

  run! if app_file == $0

end

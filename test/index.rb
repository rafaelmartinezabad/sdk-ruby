require 'sinatra'
require 'httparty'
require 'json'

require '../lib/NimbleAPI.rb'
Dir["./class/*.rb"].each {|file| require file }

class Index < Sinatra::Base

  def saveTokens( type, ticket, token, transactionId = nil )
    line = "#{ticket}:::#{type}:::#{token}:::#{transactionId}"
    res = 'OK'
    begin
      f = File.new("tokens", "a")
      f.write(line + "\n")
      f.close
    rescue Exception => msg
      res = msg.to_s
    end
    return res
  end

  def loadTokens( key )
    response = {
      'msg' => "",
      'ticket' => nil,
      'type' => nil,
      'token' => nil,
      'transactionId' => nil
    }
    begin
      tokens_table = {}
      File.open("tokens") do |fp|
        fp.each do |line|
          elem = line.chomp.split(":::")
          tokens_table[elem.shift] = elem
        end
      end
      response['msg'] = "OK"
      response['ticket'] = key
      values = tokens_table[key]
      response['type'], response['token'], response['transactionId'] = values
    rescue Exception => msg
      response['msg'] = msg.to_s
    end
    return response
  end

  def saveOAuth3( access_token, refresh_token = nil )
    res = 'OK'
    begin
      f = File.new("session", "w")
      f.write(access_token + ":::" + refresh_token)
      f.close
    rescue Exception => msg
      res = msg.to_s
    end
    return res
  end

  def loadOAuth3
    begin
      f = File.new("session", "r")
      tokens = f.read
      f.close
      res = "OK"
      access_token = tokens.split(":::")[0]
      refresh_token = tokens.split(":::")[1]
    rescue Exception => msg
      res = msg.to_s
      access_token = nil
      refresh_token = nil
    end
    return {
      'msg' => res,
      'access_token' => access_token,
      'refresh_token' => refresh_token
    }
  end

  get '/' do
    erb :index
  end

  get '/sendPayment' do
    responsePayment = request.params['responsePayment']
    if responsePayment == nil || responsePayment == ""
      res_obj = SendPayment.new.method( ClientCredentials.new, "#{request.env['HTTP_REFERER']}sendPayment" )
    end
    erb :sendPayment, :locals => {
      obj_res: res_obj,
      responsePayment: responsePayment
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

  get '/verification' do
    cc = ClientCredentials.new
    erb :verification, :locals => {
      cc: cc, obj_res: Verification.new.method( cc )
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
    ticket = request.params['ticket']
    result = request.params['result']
    if ticket != nil && result != nil
      ld = loadTokens( ticket )
      redirect "/#{ld['type']}?ticket=#{ticket}&result=#{result}"
    end
    code = request.params['code']
    if code == nil
      res_obj = GetAuth3Url.new.method( ClientCredentials.new )
    else
      res_obj = GetAdvanceAuthorization.new.method( self, ClientCredentials.new, code ) 
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
    s = loadOAuth3
    res_obj = nil
    if s['refresh_token'] != nil
      res_obj = RefreshAdvanceAuthorization.new.method( self, ClientCredentials.new, s['refresh_token'] )
    end
    erb :refreshAdvanceAuthorization, :locals => {
      load_msg: s['msg'], obj_res: res_obj
    }
  end

  get '/balance' do
    s = loadOAuth3
    res_obj = nil
    if s['access_token'] != nil
      res_obj = Balance.new.method( ClientCredentials.new, s['access_token'] )
    end
    erb :balance, :locals => {
      load_msg: s['msg'], obj_res: res_obj
    }
  end

  def getTicketInfo( ticket, result )
    access_token = nil
    transactionId = nil
    if ticket != nil && result != nil
      if result == "OK"
        s = loadTokens( ticket )
        if s['msg'] == "OK"
          access_token = s['token']
          transactionId = s['transactionId']
        end
        msg = s['msg']
      else
        msg = result
      end
    else
      s = loadOAuth3
      access_token = s['access_token']
      msg = s['msg']
    end
    return [ msg, access_token, transactionId ]
  end

  get '/cashout' do
    msg, access_token, transactionId = getTicketInfo( request.params['ticket'], request.params['result'] )
    res_obj = nil
    if access_token != nil && access_token != ""
      res_obj = Cashout.new.method( self, ClientCredentials.new, access_token )
      if res_obj != nil && res_obj['result']['code'] == 428
        res_obj['otp_url'] = GetOtpUrl.new.method(
          res_obj['data']['ticket'], 
          "#{request.env['HTTP_REFERER']}getAdvanceAuthorization"
        )
      end
    end
    erb :cashout, :locals => {
      load_msg: msg, obj_res: res_obj
    }
  end

  get '/refund' do
    msg, access_token, transactionId = getTicketInfo( request.params['ticket'], request.params['result'] )
    transactionId = request.params['transactionId'] if transactionId == nil
    res_obj = nil
    if transactionId != nil && transactionId != "" && access_token != nil && access_token != ""
      res_obj = Refund.new.method( self, ClientCredentials.new, access_token, transactionId )
      if res_obj != nil && res_obj['result']['code'] == 428
        res_obj['otp_url'] = GetOtpUrl.new.method(
          res_obj['data']['ticket'], 
          "#{request.env['HTTP_REFERER'].gsub('refund', '')}getAdvanceAuthorization"
        )
      end
    end
    erb :refund, :locals => {
      load_msg: msg, obj_res: res_obj
    }
  end

  get '/paymentdetails' do
    res_obj = nil
    s = loadOAuth3
    if s['access_token'] != nil
      transactionId = request.params['transactionId']
      if transactionId != nil && transactionId != ""
        res_obj = PaymentDetails.new.method( ClientCredentials.new, s['access_token'], transactionId )
      end
    end
    erb :paymentDetails, :locals => {
      load_msg: s['msg'], obj_res: res_obj
    }
  end

  get '/paymentslist' do
    res_obj = nil
    s = loadOAuth3
    if s['access_token'] != nil
      res_obj = PaymentsList.new.method( ClientCredentials.new, s['access_token'] )
    end
    erb :paymentsList, :locals => {
      load_msg: s['msg'], obj_res: res_obj
    }
  end

  get '/paymentrefunds' do
    res_obj = nil
    s = loadOAuth3
    if s['access_token'] != nil
      transactionId = request.params['transactionId']
      if transactionId != nil && transactionId != ""
        res_obj = PaymentRefunds.new.method( ClientCredentials.new, s['access_token'], transactionId )
      end
    end
    erb :paymentRefunds, :locals => {
      load_msg: s['msg'], obj_res: res_obj
    }
  end

  get '/paymentdisputes' do
    res_obj = nil
    s = loadOAuth3
    if s['access_token'] != nil
      transactionId = request.params['transactionId']
      if transactionId != nil && transactionId != ""
        res_obj = PaymentDisputes.new.method( ClientCredentials.new, s['access_token'], transactionId )
      end
    end
    erb :paymentDisputes, :locals => {
      load_msg: s['msg'], obj_res: res_obj
    }
  end

  get '/paymentslistfilterbydate' do
    res_obj = nil
    s = loadOAuth3
    if s['access_token'] != nil
      res_obj = PaymentsListFilterByDate.new.method( ClientCredentials.new, s['access_token'] )
    end
    erb :paymentsListFilterByDate, :locals => {
      load_msg: s['msg'], obj_res: res_obj
    }
  end

  get '/paymentslistfilterbymerchantorderid' do
    res_obj = nil
    s = loadOAuth3
    if s['access_token'] != nil
      res_obj = PaymentsListFilterByMerchantOrderId.new.method( ClientCredentials.new, s['access_token'] )
    end
    erb :paymentsListFilterByMerchantOrderId, :locals => {
      load_msg: s['msg'], obj_res: res_obj
    }
  end

  get '/paymentslistfilterbystate' do
    res_obj = nil
    s = loadOAuth3
    if s['access_token'] != nil
      res_obj = PaymentsListFilterByState.new.method( ClientCredentials.new, s['access_token'] )
    end
    erb :paymentsListFilterByState, :locals => {
      load_msg: s['msg'], obj_res: res_obj
    }
  end

  get '/paymentslistfilterbyhasrefunds' do
    res_obj = nil
    s = loadOAuth3
    if s['access_token'] != nil
      res_obj = PaymentsListFilterByHasRefunds.new.method( ClientCredentials.new, s['access_token'] )
    end
    erb :paymentsListFilterByHasRefunds, :locals => {
      load_msg: s['msg'], obj_res: res_obj
    }
  end

  get '/paymentslistfilterbyhasdisputes' do
    res_obj = nil
    s = loadOAuth3
    if s['access_token'] != nil
      res_obj = PaymentsListFilterByHasDisputes.new.method( ClientCredentials.new, s['access_token'] )
    end
    erb :paymentsListFilterByHasDisputes, :locals => {
      load_msg: s['msg'], obj_res: res_obj
    }
  end

  get '/paymentslistfilterbyentryreference' do
    res_obj = nil
    s = loadOAuth3
    if s['access_token'] != nil
      res_obj = PaymentsListFilterByEntryReference.new.method( ClientCredentials.new, s['access_token'] )
    end
    erb :paymentsListFilterByEntryReference, :locals => {
      load_msg: s['msg'], obj_res: res_obj
    }
  end

  get '/paymentslistfilterbypagination' do
    res_obj = nil
    s = loadOAuth3
    if s['access_token'] != nil
      itemReference = request.params['itemReference']
      res_obj = PaymentsListFilterByPagination.new.method( ClientCredentials.new, s['access_token'], itemReference )
    end
    erb :paymentsListFilterByPagination, :locals => {
      load_msg: s['msg'], obj_res: res_obj
    }
  end

  run! if app_file == $0

end

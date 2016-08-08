NimblePayments SDK for Ruby
======================

The NimblePayments SDK for Ruby makes it easy to add payment services to your e-commerce. It connects your site to the NimblePayments API directly.

## Release notes

### 2.0.0
It includes new Nimble Payments’ API services:

* **Payment status** (minimum information about a payment. 2-legged OAuth flow needed)
* **3-legged Oauth flow**
* **Account Balance Summary** (3-legged OAuth flow needed)
* **Get Payment Details** (it lists the details of one payment. 3-legged OAuth flow needed)
* **Get Payments List** (it filters payments made through a gateway. 3-legged OAuth flow needed)
* **Refunds** (3-legged OAuth flow and OTP needed )
* **Get Payment Refunds** (3-legged OAuth flow needed)
* **CashOut** (3-legged OAuth flow and OTP needed)

Example code tests

### 1.0.0
- First live release
- It includes the single payment service

## Requirements
* ruby 2.3.1p112 (2016-04-26 revision 54768) or above

## Installation
The SDK zip from the GitHub repository contains the NimblePayments SDK for Ruby tool, including all its dependencies. Follow the next steps to install it:

1. Download the latest/desired release zip. You will obtain a file called "_sdk-ruby-master.zip_" which includes the SDK and several samples.
2. Create a new folder inside your Ruby project directory to store NimblePayments SDK files.
3. Unzip "_sdk-ruby-master.zip_" and copy all files in the folder you have just created in the previous step.

## Working with the SDK
Once you have completed the Installation processes, you are ready to generate a payment.

## Payments 
In order to execute a payment, you will need to create a `oPayment` object with payment information and use the `sendPayment` method in the class `NimbleAPI::Payments` to send the payment

### Payment’s information
A `payment` term refers to an object that contains all the data needed in order to execute a payment. This object is an array that must be filled with the following parameters:

- `amount`: it refers to the amount that has to be paid in cents avoiding the decimal digits. The real amount has to be multiplied by 100.
- `currency`: it refers to the payment currency. It follows the currency ISO 4217 code
- `paymentSuccessUrl`: it refers to the callback URL to be redirected when the payment finishes successfully.
- `paymentErrorUrl`: it refers to the callback URL to be redirected when the payment finishes with an error.
- `merchantOrderId`: it refers to the merchant's sale identification. Example: The Prestashop`s order id.

```ruby
require './sdk-ruby/lib/NimbleAPI.rb'

# build an object with payment information
oPayment = {
    'amount' => 100,
    'currency' => "EUR",
    'paymentSuccessUrl' => "https://my-commerce.com/payments/success",
    'paymentErrorUrl' => "https://my-commerce.com/payments/error",
    'merchantOrderId' => 1234,
}
```

## Client’s  information
Client information refers to an array called “oNimbleAPI” that includes client’s credentials.

- Client’s credentials consist of a clientid, clientsecret and sandbox. Their value is the  `Api_Client_Id` and the `Client_Secret` codes generated when creating a Payment gateway in the Nimble dashboard, and sandbox indicate the environment.

## Examples

### Example 1: Environment verification
It allows to verify the environment the API_clientId and clientSecret application credentials belongs to.

```ruby
require './sdk-ruby/lib/NimbleAPI.rb'

# build an object with client API information
oNimbleAPI = NimbleAPI.new(
    '729DFCD7A2B4643A0DA3D4A7E537FC6E', # a valid Api_Client_Id
    'jg26cI3O1mB0$eR&fo6a2TWPmq&gyQoUOG6tClO%VE*N$SN9xX27@R4CTqi*$4EO' # a valid Client_Secret
)

# High & Low Level call
response = NimbleAPI::Environment.new.verification( oNimbleAPI )
```

### Example 2: Payment generation
To generate a Payment please follow the steps bellow:

- Build an object with the payment information
- Build an object with client information (`Api_Client_Id` and `Client_Secret`)
- Create a `oNimbleAPI` object
- Use the `sendPayment` method in the class `NimbleAPI::Payments` to send the payment

```ruby
require './sdk-ruby/lib/NimbleAPI.rb'

# build an object with payment information
oPayment = {
    'amount' => 1000,
    'currency' => "EUR",
    'paymentSuccessUrl' => "https://my-commerce.com/payments/success",
    'paymentErrorUrl' => "https://my-commerce.com/payments/error",
    'merchantOrderId' => "test-merchant-id",
}

# build an object with client API information
oNimbleAPI = NimbleAPI.new(
    '729DFCD7A2B4643A0DA3D4A7E537FC6E', # a valid Api_Client_Id
    'jg26cI3O1mB0$eR&fo6a2TWPmq&gyQoUOG6tClO%VE*N$SN9xX27@R4CTqi*$4EO' # a valid Client_Secret
)

response = NimbleAPI::Payments.new.sendPayment( oNimbleAPI, oPayment )
```
If the `sendPayment` call is correct, the response will contain the new transaction id. This transaction id could be used later to view and check the new transaction in the NimblePayments's site. Also is returned the URL to show to the client for introduce the payment data information.

That payment URL must contain all the parameters needed, just for charge that URL in the web browser (or web view in the case of mobile devices).

### Example 3: Payment status
The payment status could be checked using the Nimble Payments unique `transactionId`. It is also possible to check the status by the `merchantOrderId`, but Nimble Payments does not guarantee its uniqueness.

#### Payment status by transactionId
```ruby
require './sdk-ruby/lib/NimbleAPI.rb'

# build an object with client API information
oNimbleAPI = NimbleAPI.new(
    '729DFCD7A2B4643A0DA3D4A7E537FC6E', # a valid Api_Client_Id
    'jg26cI3O1mB0$eR&fo6a2TWPmq&gyQoUOG6tClO%VE*N$SN9xX27@R4CTqi*$4EO' # a valid Client_Secret
)

transactionId = 807809 # A real trasactionId obtained on payment generation

response = NimbleAPI::Payments.new.getStatusByTransactionId( oNimbleAPI, transactionId )
```

#### Payment status by merchantOrderId
```ruby
require './sdk-ruby/lib/NimbleAPI.rb'

# build an object with client API information
oNimbleAPI = NimbleAPI.new(
    '729DFCD7A2B4643A0DA3D4A7E537FC6E', # a valid Api_Client_Id
    'jg26cI3O1mB0$eR&fo6a2TWPmq&gyQoUOG6tClO%VE*N$SN9xX27@R4CTqi*$4EO' # a valid Client_Secret
)

merchantOrderId = 'idSample12345' # A real merchantOrderId the same as oPayment object

response = NimbleAPI::Payments.new.getStatusByMerchantOrderId( oNimbleAPI, merchantOrderId )
```

### Example 4: 3-legged OAuth flow
Services that access to client information such as refunds and cashout need a 3-legged OAuth flow  authorization. In order to obtain a 3-legged OAuth token, please follow the steps bellow:

#### Step 1 - Open authorization url
```ruby
require './sdk-ruby/lib/NimbleAPI.rb'

# build an object with client API information
oNimbleAPI = NimbleAPI.new(
    '729DFCD7A2B4643A0DA3D4A7E537FC6E', # a valid Api_Client_Id
    'jg26cI3O1mB0$eR&fo6a2TWPmq&gyQoUOG6tClO%VE*N$SN9xX27@R4CTqi*$4EO' # a valid Client_Secret
)

oNimbleAPI.getAuth3Url
```

#### Step 2 - User must sign in and authorize
Once the user has given her/his authorization, she/he will be redirect to the *gateway redirect url*

#### Step 3 - Capture code parameter and obtain tokens
```ruby
require './sdk-ruby/lib/NimbleAPI.rb'

# build an object with client API information
oNimbleAPI = NimbleAPI.new(
    '729DFCD7A2B4643A0DA3D4A7E537FC6E', # a valid Api_Client_Id
    'jg26cI3O1mB0$eR&fo6a2TWPmq&gyQoUOG6tClO%VE*N$SN9xX27@R4CTqi*$4EO' # a valid Client_Secret
)

code = request.params['code']

oNimbleAPI.authorize( code )

oNimbleAPI.getAccessToken # TOKEN_3LEGGED
oNimbleAPI.getRefreshToken # REFRESH_TOKEN
```

### Example 6: Account Balance Summary
The Balance Summary service is used to get the merchant’s Nimble account balance. This service give information about total available, hold account and balance account.
```ruby
require './sdk-ruby/lib/NimbleAPI.rb'

# build an object with client API information
oNimbleAPI = NimbleAPI.new(
    '729DFCD7A2B4643A0DA3D4A7E537FC6E', # a valid Api_Client_Id
    'jg26cI3O1mB0$eR&fo6a2TWPmq&gyQoUOG6tClO%VE*N$SN9xX27@R4CTqi*$4EO' # a valid Client_Secret
)

# after 3-legged OAuth flow (Example 4) #

user_tsec = oNimbleAPI.getAccessToken # TOKEN_3LEGGED

response = NimbleAPI::Account.new.balance( oNimbleAPI, user_tsec )
```

### Example 7: Refunds
Making a refund is an action protected by a second factor authorization, meaning that the user must inform about an OTP (One Time Password) sent to its mobile phone to execute the transaction.

In order to make a refund, first you need to obtain a 3-legged token and this token will allow you to obtain the OTP token and the related ticket as follow:
#### Call method NimbleAPI::Payments.new.paymentRefunds
```ruby
require './sdk-ruby/lib/NimbleAPI.rb'

# build an object with client API information
oNimbleAPI = NimbleAPI.new(
    '729DFCD7A2B4643A0DA3D4A7E537FC6E', # a valid Api_Client_Id
    'jg26cI3O1mB0$eR&fo6a2TWPmq&gyQoUOG6tClO%VE*N$SN9xX27@R4CTqi*$4EO' # a valid Client_Secret
)

# after 3-legged OAuth flow (Example 4) #

user_tsec = oNimbleAPI.getAccessToken # TOKEN_3LEGGED

transactionId = 3735 # A real trasactionId obtained on payment generation

oRefund = {
    "amount" => 100,
    "concept" => "Shoes",
    "reason" => "REQUEST_BY_CUSTOMER"
}

response = NimbleAPI::Payments.new.refund( oNimbleAPI, user_tsec, transactionId, oRefund )
```

The OTP token, the ticket and the refund information must be saved to be used later on:
#### Save obtained token, ticket & refund information
```ruby
ticket = response['data']['ticket']
otp_token = response['data']['token']
info_refund = {
    :oRefund => oRefund,
    :transactionId => transactionId,
    :otp_token => otp_token
}

save_method(info_refund) # some kind of function to save neccesary information
```

Final user must be redirected to the OTP form
#### Open OTP form url
```ruby
redirect_url = 'http://nimblesdkruby.com/getAdvanceAuthorization'; //Gateway redirect url
url_otp = NimbleAPI.getOtpUrl( ticket, redirect_url )
redirect url_otp
```

Once the user fills up the form with a correct OTP, user will be redirect to the gateway redirect url.
If the OTP was a valid one, the OTP token has the privileges to call the refund service. Using previous OTP token and the saved refund information, the refund service must be call again.

#### Capture ticket parameter and call method NimbleAPI::Payments.new.paymentRefunds
```ruby
require './sdk-ruby/lib/NimbleAPI.rb'

ticket = request.params['ticket']

info_refund = load_method(ticket) # some kind of function to load ticket information

# build an object with client API information
oNimbleAPI = NimbleAPI.new(
    '729DFCD7A2B4643A0DA3D4A7E537FC6E', # a valid Api_Client_Id
    'jg26cI3O1mB0$eR&fo6a2TWPmq&gyQoUOG6tClO%VE*N$SN9xX27@R4CTqi*$4EO' # a valid Client_Secret
)

user_tsec = info_refund['otp_token']

transactionId = info_refund['transactionId']

oRefund = info_refund['oRefund']

response = NimbleAPI::Payments.new.refund( oNimbleAPI, user_tsec, transactionId, oRefund )
```

## Installing Tests

In `./test` folder you will find scripts implementing a basics operations that uses NimblePayments SDK as payment platform.

Next example steps asumes working with Ubuntu 14.04 LTS, Apache2 and ruby 2.3.1p112 (2016-04-26 revision 54768) or above.
### 1. Download code
```bash
cd /var/www
git clone https://github.com/nimblepayments/sdk-ruby.git
cp sdk-ruby/test/class/gateway_config_sample.rb_sample sdk-ruby/test/class/gateway_config.rb
```
### 2. Enter your Nimble Payments gateway credentials
Obtain it from [www.nimblepayments.com](https://www.nimblepayments.com/)

Create new gateway with the following options:
```
Where do you use? -> Own development
URL -> http://nimblesdkruby.com
URL redirection -> http://nimblesdkruby.com/getAdvanceAuthorization
```

Use your favorite text editor to modify `sdk-ruby/test/class/gateway_config.rb`
```bash
nano sdk-ruby/test/class/gateway_config.rb
```
### 3. Configure Apache Virtual Host
Copy apache virtual host example on /etc/apache2/sites-available/nimble-sdk-ruby.conf:
```bash
<VirtualHost *:80>
  ServerName nimblesdkruby.com
  ProxyPass / http://localhost:4567/
  ProxyPassReverse / http://localhost:4567/
  ErrorLog /var/log/apache2/localnimblesdkruby-error_log
  CustomLog /var/log/apache2/localnimblesdkruby-access_log common
</VirtualHost>
```
### 4. Add new sample domain
Add a new line on /etc/hosts:
```bash
127.0.0.1       nimblesdkruby.com
```
### 5. Enable virtual host and restart apache:
```bash
sudo a2ensite nimble-sdk-ruby.conf
sudo a2enmod proxy
sudo a2enmod proxy_http
sudo service apache2 restart
```
### 6. Start ruby tests
```bash
cd /var/www/sdk-ruby/test
bundle install
ruby index.rb
```
### 7. Open sample domain
Open on your navigation [nimblesdkruby.com](http://nimblesdkruby.com/)

##Environment
There are two different environment options:

- Sandbox. It is used in the demo environment to make tests.
- Real. It is used to work in the real environment.

The sandbox environment is disabled by default. To activate it, the variable `sandbox` must be manually set to `true` in NimbleAPI construct. Example:
```ruby
oNimbleAPI = NimbleAPI.new(
    '729DFCD7A2B4643A0DA3D4A7E537FC6E',
    'jg26cI3O1mB0$eR&fo6a2TWPmq&gyQoUOG6tClO%VE*N$SN9xX27@R4CTqi*$4EO',
    true # Sandbox variable, false by default
)
```
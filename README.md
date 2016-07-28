NimblePayments SDK for Ruby
======================

The NimblePayments SDK for Ruby makes it easy to add payment services to your e-commerce. It connects your site to the NimblePayments API directly.

## Release notes

### 1.0.0
- First live release
- It includes the single payment service

## Requirements
* ruby 2.3.1p112 (2016-04-26 revision 54768) [x86_64-linux] or above

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

- Client’s credentials consist of a clientid, clientsecret and sandbox. Their value is the  `client_Id` and the `client_Secret` codes  generated when creating a Payment gateway in the Nimble dashboard.

## Example of a Payment generation
To generate a Payment you will need to execute the following steps:

- Build an object with the payment information
- Build an object with client information (`Api_Client_Id`, `Client_Secret` and `sandbox`)
- Create a `oNimbleAPI` object
- Use the `sendPayment` method in the class `NimbleAPI::Payments` to send the payment

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

# build an object with client API information
sandbox = false
oNimbleAPI = NimbleAPI.new(
    '729DFCD7A2B4643A0DA3D4A7E537FC6E',
    'jg26cI3O1mB0$eR&fo6a2TWPmq&gyQoUOG6tClO%VE*N$SN9xX27@R4CTqi*$4EO',
    sandbox
)

response = NimbleAPI::Payments.new.sendPayment( oNimbleAPI, oPayment )
```
If the sendPayment call is correct, the response will contain the new transaction id. This transaction id could be used later to view and check the new transaction in the NimblePayments's site. Also is returned the URL to show to the client for introduce the payment data information.

That payment URL must contain all the parameters needed, just for charge that URL in the web browser (or web view in the case of mobile devices).

##Environment
There are two different environment options:
- Sandbox.It is used in the demo environment to make tests.
- Real. It is used to work in the real environment.

The sandbox environment is disabled by default. To activate it, the variable `sandbox` must be manually set to `true`.

## Test

In `test` folder you will find scripts implementing a basics operations that uses NimbleePayments SDK as payment platform.

## Documentation
Please see [Apiary](http://docs.nimblepublicapi.apiary.io/#) for up-to-date documentation.

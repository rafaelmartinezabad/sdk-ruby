NimblePayments SDK for Ruby
======================

The NimblePayments SDK for Ruby makes it easy to add payment services to your e-commerce. It connects your site to the NimblePayments API directly.

## Requirements
* Ruby on Rails 1.9 or above

## Installation
The SDK zip from the GitHub repository contains the NimblePayments SDK for Ruby tool, including all its dependencies. Follow the next steps to install it:

1. Download the latest/desired release zip. You will obtain a file called "_sdk-ruby-master.zip_" which includes the SDK and several samples.
2. Create a new folder inside your Ruby project directory to store NimblePayments SDK files.
3. Unzip "_sdk-ruby-master.zip_" and copy all files in the folder you have just created in the previous step.

## Working with the SDK
Once you have completed the Installation processes, you are ready to generate a payment.

## Payments 
In order to execute a payment, you will need to create a `oNimbleApi` object with client information, `oPayment` object with payment information and use the `sendPayment` method in the class `NimbleAPI::Payments` to send the payment

### Payment’s information
A `payment` term refers to an object that contains all the data needed in order to execute a payment. This object is an array that must be filled with the following parameters:

- `amount`: it refers to the amount that has to be paid in cents avoiding the decimal digits. The real amount has to be multiplied by 100.
- `currency`: it refers to the payment currency. It follows the currency ISO 4217 code
- `paymentSuccessUrl`: it refers to the callback URL to be redirected when the payment finishes successfully.
- `paymentErrorUrl`: it refers to the callback URL to be redirected when the payment finishes with an error.
- `merchantOrderId`: it refers to the merchant's sale identification. Example: The Prestashop`s order id.

```ruby
require './sdk-ruby/lib/NimbleAPI.rb'

# build an array with payment information
oPayment = {
    'amount' => 100,
    'currency' => "EUR",
    'paymentSuccessUrl' => "https://my-commerce.com/payments/success",
    'paymentErrorUrl' => "https://my-commerce.com/payments/error",
    'merchantOrderId' => 1234,
}
```

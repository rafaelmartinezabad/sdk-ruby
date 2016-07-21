require 'rubygems' if RUBY_VERSION < '1.9'

class NimbleAPI
    class Config

        # @var string OAUTH_URL constant var, with the base url to connect with Oauth
        OAUTH_URL = "https://www.nimblepayments.com/auth/tsec/token"
        OAUTH3_URL_AUTH = "https://www.nimblepayments.com/auth/tsec/authorize"
        OTP_URL = "https://www.nimblepayments.com/auth/otp"

        # @var string NIMBLE_API_BASE_URLs constant var, with the base url of live enviroment to make requests
        NIMBLE_API_BASE_URL = "https://www.nimblepayments.com/api"

        # @var string NIMBLE_API_BASE_URLs constant var, with the base url of demo enviroment to make requests
        NIMBLE_API_BASE_URL_DEMO = "https://www.nimblepayments.com/sandbox-api"

        # @var string GATEWAY_URL constant var
        GATEWAY_URL = "https://www.nimblepayments.com/private/partners/payment-gateway"
        
        # @var int TIMEOUT (seconds) constant var
        TIMEOUT = 30
    end
end
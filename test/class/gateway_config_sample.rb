require 'rubygems'
require 'bundler/setup'

class ClientCredentialsSample

	attr_reader :clientId, :clientSecret, :sandbox

	def initialize
		@sandbox = false
		@clientId = '729DFCD7A2B4643A0DC3D4A7E537FC6E'
		@clientSecret = 'jg26cI3O1mB0$eR&fo6a2TWPmq&gyQoUOG6tClO%VE*N$SN9xX27@R4CTqi*$4EO'
	end

end
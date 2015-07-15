require 'twilio-ruby'

class TwilioController < ApplicationController
	include Webhookable

	after_filter :set_header

	skip_before_action :verify_authenticity_token

	def response
		logger.info params
	end
end

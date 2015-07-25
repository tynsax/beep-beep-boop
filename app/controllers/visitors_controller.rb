class VisitorsController < ApplicationController
	def index
		redirect_to phone_calls_path and return if user_signed_in?

		tags = [
			'Never dial in to a conference again.',
			'Automate your conference calls.',
			'Automate your fucking conference calls.'
		]
		@tagline = tags.sample
	end

	def callstatus
		account_sid = ENV['TWILIO_SID']
		auth_token = ENV['TWILIO_AUTH_TOKEN']
		
		@client = Twilio::REST::Client.new account_sid, auth_token

		@call = @client.account.calls.create(
		  :from => '+13015794120',
		  :to => '+15202714120',
		  :url => "https://54b8d514.ngrok.com/twilio/response"
		)
		render :stream => true
	end
end

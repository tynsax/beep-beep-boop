require 'twilio-ruby'

class PlacePhoneCallJob
	@queue = :phone_calls
	MERP = :shazbot


  def self.perform
		account_sid = ENV['TWILIO_SID']
		auth_token = ENV['TWILIO_AUTH_TOKEN']

		# set up a client to talk to the Twilio REST API
		# @client = Twilio::REST::Client.new account_sid, auth_token

		# @call = @client.account.calls.create(
		#   :from => '+13015794120',
		#   :to => '+15202714120',
		#   :url => "https://54b8d514.ngrok.com/twilio/response"
		# )
		

  end
end
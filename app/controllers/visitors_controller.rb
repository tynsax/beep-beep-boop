class VisitorsController < ApplicationController
	def index
		redirect_to phone_calls_path and return if user_signed_in?

		tags = [
			'Never dial in to a conference again.',
			'Automate your conference calls.',
			'Dialing a phone is so last century.'
		]
		@tagline = tags.sample
	end
end

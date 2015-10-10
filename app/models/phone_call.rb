class PhoneCall < ActiveRecord::Base
  belongs_to :user
  include NonNullUuid

  phony_normalize :to, default_country_code: 'US'
  validates :to, phony_plausible: true, presence: true

  after_create :place_call

  def place_call
    @client = Twilio::REST::Client.new
    @client.calls
    @call = @client.calls.create(
      from: '+' + Rails.application.secrets.twilio_num.to_s,
      to: user.phone,
      url: 'https://' + Rails.application.secrets.domain_name +
        '/phone_calls/' + self.uuid,
      'IfMachine': 'Hangup',
      callerId: user.phone
    )

  end

end

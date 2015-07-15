class PhoneCall < ActiveRecord::Base
  belongs_to :user
  include NonNullUuid

  after_create :place_call

  def place_call
    @client = Twilio::REST::Client.new
    @client.calls
    @call = @client.calls.create(
      from: '+' + Rails.application.secrets.twilio_num.to_s,
      to: '+1' + user.phone,
      url: 'https://' + Rails.application.secrets.domain_name +
        '/phone_calls/' + self.uuid
    )

  end

end

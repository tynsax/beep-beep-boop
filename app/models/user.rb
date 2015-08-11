class User < ActiveRecord::Base
  has_many :phone_calls
  has_many :memberships

  phony_normalize :phone, :default_country_code => 'US'
  validates_plausible_phone :phone, :normalized_country_code => 'US'

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
         user.name = auth['info']['name'] || ''
         user.email = auth['info']['email'] || ''
         user.image = auth['info']['image'] || ''
      end
    end
  end

  def call_log
    self.phone_calls
  end

  def membership_level
    return MembershipLevel.first if memberships.empty?
  end

end

class User < ActiveRecord::Base
  has_many :phone_calls
  has_many :memberships
  has_many :phones

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
    memberships.last.membership_level
  end

  def calls_made_today
    PhoneCall.where('user_id = ? and created_at > ?',
      id, Time.zone.now - 1.day)
  end

  def remaining_calls
    5 - calls_made_today.count
  end

  def remaining_calls?
    remaining_calls > 0 ? true : false
  end
end

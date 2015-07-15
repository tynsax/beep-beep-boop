class User < ActiveRecord::Base
  has_many :phone_calls

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

end

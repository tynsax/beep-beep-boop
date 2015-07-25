class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :membership_level
end

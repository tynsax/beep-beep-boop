module MembershipStatus
  extend ActiveSupport::Concern

  def membership_level
    return MembershipLevel.first if memberships.empty?
    memberships.last.membership_level
  end

  def calls_made_today
    PhoneCall.where('user_id = ? and created_at > ?',
      id, Time.zone.now - 1.day)
  end

  def remaining_calls_today
    return nil if membership_level.daily_call_limit.nil? # unlimited
    membership_level.daily_call_limit.to_i - calls_made_today.count
  end

  def remaining_calls_today?
    return true if remaining_calls_today.nil? # unlimited
    remaining_calls_today > 0 ? true : false
  end
end

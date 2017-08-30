class AddDailyCallLimitToMembershipLevels < ActiveRecord::Migration
  def change
  	add_column :membership_levels, :daily_call_limit, :integer
  end
end

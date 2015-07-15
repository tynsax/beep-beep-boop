class AddScheduledAtToPhoneCalls < ActiveRecord::Migration
  def change
    add_column :phone_calls, :scheduled_at, :datetime
  end
end

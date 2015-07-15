class AddSidToPhoneCalls < ActiveRecord::Migration
  def change
    add_column :phone_calls, :twilio_sid, :string
  end
end

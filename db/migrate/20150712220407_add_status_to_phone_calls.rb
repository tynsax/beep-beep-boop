class AddStatusToPhoneCalls < ActiveRecord::Migration
  def change
    add_column :phone_calls, :status, :string
  end
end

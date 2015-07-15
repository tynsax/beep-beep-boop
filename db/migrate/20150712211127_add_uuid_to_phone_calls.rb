class AddUuidToPhoneCalls < ActiveRecord::Migration
  def change
    add_column :phone_calls, :uuid, :string
  end
end

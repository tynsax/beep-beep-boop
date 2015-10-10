class AddAnsweredByToPhoneCalls < ActiveRecord::Migration
  def change
    add_column :phone_calls, :answered_by, :string
  end
end

class AddClipboardToPhoneCalls < ActiveRecord::Migration
  def change
    add_column :phone_calls, :clipboard, :text
  end
end

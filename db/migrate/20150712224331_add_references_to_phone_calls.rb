class AddReferencesToPhoneCalls < ActiveRecord::Migration
  def change
    add_reference :phone_calls, :user, index: true, foreign_key: true
  end
end

class CreatePhoneCalls < ActiveRecord::Migration
  def change
    create_table :phone_calls do |t|
      t.string :to
      t.string :from
      t.string :duration
      t.string :access_code
      t.string :result

      t.timestamps
    end
  end
end

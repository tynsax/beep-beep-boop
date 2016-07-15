class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.string :icon
      t.string :number
      t.time :confirmed_at

      t.timestamps null: false
    end
  end
end

class CreateMembershipLevels < ActiveRecord::Migration
  def change
    create_table :membership_levels do |t|
      t.string :name
      t.text :description
      t.integer :monthly_fee

      t.timestamps null: false
    end
  end
end

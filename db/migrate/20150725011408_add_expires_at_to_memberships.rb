class AddExpiresAtToMemberships < ActiveRecord::Migration
  def change
    add_column :memberships, :expires_at, :datetime
  end
end

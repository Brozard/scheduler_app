class RemoveUserIdFromAuthorizations < ActiveRecord::Migration
  def change
    remove_column :authorizations, :user_id, :integer
  end
end

class RemoveUserTimezoneRefFromUser < ActiveRecord::Migration
  def change
    remove_reference :users, :user_timezone, foreign_key: true
  end
end

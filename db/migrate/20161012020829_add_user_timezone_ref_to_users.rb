class AddUserTimezoneRefToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :user_timezone, foreign_key: true
  end
end

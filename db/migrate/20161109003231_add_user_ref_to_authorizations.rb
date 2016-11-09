class AddUserRefToAuthorizations < ActiveRecord::Migration
  def change
    add_reference :authorizations, :user, foreign_key: true
  end
end

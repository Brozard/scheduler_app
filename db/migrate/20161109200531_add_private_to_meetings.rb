class AddPrivateToMeetings < ActiveRecord::Migration
  def change
    add_column :meetings, :private, :boolean
  end
end

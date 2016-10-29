class DropUserTimezone < ActiveRecord::Migration
  def change
    drop_table :user_timezones
  end
end

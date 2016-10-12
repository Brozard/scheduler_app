class CreateUserTimezones < ActiveRecord::Migration
  def change
    create_table :user_timezones do |t|
      t.string :name
      t.string :abbreviation
      t.integer :offset

      t.timestamps null: false
    end
  end
end

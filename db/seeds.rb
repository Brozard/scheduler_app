# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

timezones = [
  ['Atlantic', 'AST', -4],
  ['Eastern', 'EST', -5],
  ['Central', 'CST', -6],
  ['Mountain', 'MST', -7],
  ['Pacific', 'PST', -8]
]

timezones.length.times do |i|
  UserTimezone.find_or_create_by(name: timezones[i][0], abbreviation: timezones[i][1], offset: timezones[i][2])
end
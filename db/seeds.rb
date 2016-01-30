# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


tournament = Tournament.create!(
  name: "NCAA",
  event: "Men's Basketball",
  start_date: Date.new(2013, 3, 1)
)
teams = YAML.load_file(
  Rails.root.join('db', 'fixtures', 'teams.yml'))
teams.each { |team| tournament.teams.create!(team) }

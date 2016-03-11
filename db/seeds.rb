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
  start_date: Date.new(2013, 3, 1),
  region0: 'South',
  region1: 'East',
  region2: 'Midwest',
  region3: 'West'
)
teams = YAML.load_file(
  Rails.root.join('db', 'fixtures', 'teams.yml'))
teams.each { |team| tournament.teams.create!(team) }

0.upto(62) do |position|
  game = tournament.games.build(
    position: position,
    start_time: Date.new(2013, 3, 1 + rand(30))
  )
  game.update_teams
  game.save!
end

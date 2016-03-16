
FactoryGirl.define do
  factory :tournament do
    name 'NCAA'
    event "Men's Basketball"
    start_date Date.new(2013, 3, 1)
    region0 'South'
    region1 'East'
    region2 'Midwest'
    region3 'West'
  end

  factory :game, class: Game do
    start_time Date.new(2013, 3, 1)
    tournament
  end
end

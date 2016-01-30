
FactoryGirl.define do
  factory :tournament do
    name 'NCAA'
    event "Men's Basketball"
    start_date Date.new(2013, 3, 1)
  end

  factory :game, class: Tournament::Game do
    start_time Date.new(2013, 3, 1)
    tournament
  end
end

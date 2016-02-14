# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :bracket do
    tournament_id 1
    user_id 1
    picks "MyText"
  end
end

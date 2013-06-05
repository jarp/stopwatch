# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :developer do
    first_name "Test"
    last_name "McDev"
    email "test@test.com"
    password "go irish"
  end
end

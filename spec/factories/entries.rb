# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :entry do
    date "2013-05-27"
    description "MyText"
    hours "MyString"
    developer 
    project 
    category 
  end
end

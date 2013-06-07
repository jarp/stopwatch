# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :entry do
    date "2013-05-27"
    description "Basic Description..."
    hours "1h"
    #state ""
    developer 
    project 
    category 
  end
end

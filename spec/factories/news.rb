# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :news do
    sequence(:title) {|n| "News #{n}"}
    description "Description"
  end
end
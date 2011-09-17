# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    sequence(:name) {|n| "Project #{n}"}
    sequence(:identifier) {|n| "project_#{n}"}
    status Project::STATUS_ACTIVE
  end
  
  factory :public_project, :parent => :project do
    is_public true
  end
  
  factory :private_project, :parent => :project do
    is_public false
  end
end
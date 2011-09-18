# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    firstname 'Bob'
    lastname 'Bobbit'
    sequence(:login) {|n| "bob_#{n}"}
    sequence(:mail) {|n| "bob_#{n}@bobbit.com"}
    password 'bob'
    password_confirmation 'bob'
    language 'en'
    status User::STATUS_ACTIVE
    admin false
  end

  factory :user_admin, :class => User do
    firstname 'Redmine'
    lastname 'Admin'
    login 'admin'
    mail 'admin@example.com'
    password 'admin'
    password_confirmation 'admin'
    admin true
  end
end
FactoryGirl.define do
  factory :user do
    sequence(:name)     { |n| "User #{n}" }
    sequence(:nickname) { |n| "nickname#{n}" }
    sequence(:email)    { |n| "user-#{n}@example.com" }
  end
end

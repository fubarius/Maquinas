FactoryGirl.define do
  factory :authentication do
    provider "FactoryGirl"
    sequence(:uid) { |n| "this-is-uid-#{n}" }
    user
  end
end

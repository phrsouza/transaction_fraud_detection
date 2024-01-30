# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    trait :with_transaction do
      after(:create) do |user|
        create(:transaction, user:)
      end
    end
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :device do
    trait :with_transaction do
      after(:create) do |device|
        create(:transaction, device:)
      end
    end
  end
end

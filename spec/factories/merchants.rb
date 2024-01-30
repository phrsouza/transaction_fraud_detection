# frozen_string_literal: true

FactoryBot.define do
  factory :merchant do
    trait :with_transaction do
      after(:create) do |merchant|
        create(:transaction, merchant:)
      end
    end
  end
end

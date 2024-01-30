# frozen_string_literal: true

FactoryBot.define do
  factory :transaction do
    card_number { 'MyString' }
    chargebacked_at { nil }
    amount { '9.99' }
    device
    user
    merchant

    trait :chargebacked do
      chargebacked_at { Time.current }
    end
  end
end

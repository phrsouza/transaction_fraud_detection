# frozen_string_literal: true

FactoryBot.define do
  factory :transaction do
    card_number { 'MyString' }
    chargebacked_at { '2024-01-29 20:35:15' }
    amount { '9.99' }
    device
    user
    merchant
  end
end

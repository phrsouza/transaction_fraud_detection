# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :device
  belongs_to :user
  belongs_to :merchant
end

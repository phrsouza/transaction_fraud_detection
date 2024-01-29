# frozen_string_literal: true

class Sample < ApplicationRecord
  validates :title, presence: true
end

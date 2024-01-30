# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transaction do
  describe 'associations' do
    it { is_expected.to belong_to(:device).optional(true) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:merchant) }
  end
end

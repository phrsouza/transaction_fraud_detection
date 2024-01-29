# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Sample do
  it 'is not valid without a title' do
    sample = described_class.new(title: nil)

    expect(sample.valid?).to be(false)
  end
end

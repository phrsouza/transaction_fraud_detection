require 'rails_helper'

RSpec.describe Device, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:transactions).dependent(:restrict_with_error) }
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AntiFraudRules::HighAmountInPeriod do
  describe '.call' do
    subject(:high_amount_in_period) do
      described_class.call(
        transaction_data: {
          transaction_amount:,
          transaction_date:
        }
      )
    end

    context 'when transaction does not exceeed the maximum amount' do
      let(:transaction_amount) { described_class::MAX_AMOUNT }

      context 'when transaction date is out of the observed period' do
        let(:transaction_date) { Time.current.change({ hour: described_class::START_HOUR - 1 }) }

        it 'returns false' do
          expect(high_amount_in_period).to be false
        end
      end

      context 'when transaction date is within the observed period' do
        let(:transaction_date) { Time.current.change({ hour: described_class::START_HOUR }) }

        it 'returns false' do
          expect(high_amount_in_period).to be false
        end
      end
    end

    context 'when transaction exceeeds the maximum amount' do
      let(:transaction_amount) { described_class::MAX_AMOUNT + 1 }

      context 'when transaction date is out of the observed period' do
        let(:transaction_date) { Time.current.change({ hour: described_class::START_HOUR - 1 }) }

        it 'returns false' do
          expect(high_amount_in_period).to be false
        end
      end

      context 'when transaction date is within the observed period' do
        let(:transaction_date) { Time.current.change({ hour: described_class::START_HOUR }) }

        it 'returns true' do
          expect(high_amount_in_period).to be true
        end
      end
    end
  end
end

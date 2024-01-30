# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AntiFraudRules::UserTransactionsExceeded do
  describe '.call' do
    context 'when does not exist a previous transaction within the time interval' do
      it 'returns false' do
        Timecop.freeze do
          previous_transaction = create(:transaction, created_at: (described_class::TIME_INTERVAL + 1).ago)

          rule_result = described_class.call(
            transaction_data: {
              user_id: previous_transaction.user_id,
              transaction_date: Time.current
            }
          )

          expect(rule_result).to be false
        end
      end
    end

    context 'when exists a previous transaction within the time interval' do
      it 'returns true' do
        Timecop.freeze do
          previous_transaction = create(:transaction, created_at: described_class::TIME_INTERVAL.ago)

          rule_result = described_class.call(
            transaction_data: {
              user_id: previous_transaction.user_id,
              transaction_date: Time.current
            }
          )

          expect(rule_result).to be true
        end
      end
    end
  end
end

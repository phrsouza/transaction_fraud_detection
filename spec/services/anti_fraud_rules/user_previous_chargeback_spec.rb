# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AntiFraudRules::UserPreviousChargeback do
  describe '.call' do
    context 'when does not exist a previous chargeback transaction for the user' do
      it 'returns false' do
        Timecop.freeze do
          previous_transaction = create(:transaction, chargebacked_at: nil)

          rule_result = described_class.call(
            transaction_data: {
              user_id: previous_transaction.user_id
            }
          )
          expect(rule_result).to be false
        end
      end
    end

    context 'when exists a previous chargeback transaction for the user' do
      it 'returns true' do
        Timecop.freeze do
          chargebacked_transaction = create(:transaction, :chargebacked)

          rule_result = described_class.call(
            transaction_data: {
              user_id: chargebacked_transaction.user_id
            }
          )
          expect(rule_result).to be true
        end
      end
    end
  end
end

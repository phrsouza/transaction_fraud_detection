# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CheckFraud do
  describe '::DEFAULT_RULES' do
    it 'return configured default rules' do
      expect(described_class::DEFAULT_RULES).to eq(
        [
          AntiFraudRules::HighAmountInPeriod,
          AntiFraudRules::UserPreviousChargeback,
          AntiFraudRules::UserTransactionsExceeded
        ]
      )
    end
  end

  describe '.call' do
    subject(:check_fraud) do
      described_class.call(transaction_data:)
    end

    let(:transaction_data) do
      {
        transaction_id: 2_342_357,
        merchant_id: 29_744,
        user_id: 97_051,
        card_number: '434505******9116',
        transaction_date: Time.zone.parse('2019-11-31T23:16:32.812632'),
        transaction_amount: 373,
        device_id: 285_475
      }
    end

    before do
      described_class::DEFAULT_RULES.each do |rule_class|
        allow(rule_class).to receive(:call).and_return(false)
      end
    end

    context 'when all rules return false' do
      it 'returns false' do
        expect(check_fraud).to be false
      end

      it 'calls all the rules' do
        check_fraud

        expect(AntiFraudRules::HighAmountInPeriod).to have_received(:call).with(transaction_data:)
        expect(AntiFraudRules::UserPreviousChargeback).to have_received(:call).with(transaction_data:)
        expect(AntiFraudRules::UserTransactionsExceeded).to have_received(:call).with(transaction_data:)
      end
    end

    context 'when the first rule returns true' do
      before do
        allow(described_class::DEFAULT_RULES.first).to receive(:call).and_return(true)
      end

      it 'returns true' do
        expect(check_fraud).to be true
      end

      it 'does not run the remaining rules' do
        check_fraud

        expect(AntiFraudRules::HighAmountInPeriod).to have_received(:call).with(transaction_data:)
        expect(AntiFraudRules::UserPreviousChargeback).not_to have_received(:call)
        expect(AntiFraudRules::UserTransactionsExceeded).not_to have_received(:call)
      end
    end
  end
end

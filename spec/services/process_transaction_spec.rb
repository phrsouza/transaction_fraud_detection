# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProcessTransaction do
  describe '.call' do
    subject(:process_transaction) { described_class.call(transaction_data:) }

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

    context 'when transaction is a fraud' do
      before do
        allow(CheckFraud).to receive(:call).with(transaction_data:).and_return(true)
      end

      it 'returns a deny response' do
        expect(process_transaction).to eq(
          {
            recommendation: 'deny',
            transaction_id: transaction_data[:transaction_id]
          }
        )
      end

      it 'calls CheckFraud' do
        process_transaction

        expect(CheckFraud).to have_received(:call).with(transaction_data:)
      end
    end

    context 'when transaction is legit' do
      before do
        allow(CheckFraud).to receive(:call).with(transaction_data:).and_return(false)
      end

      it 'returns an approve response' do
        expect(process_transaction).to eq(
          {
            recommendation: 'approve',
            transaction_id: transaction_data[:transaction_id]
          }
        )
      end

      it 'calls CheckFraud' do
        process_transaction

        expect(CheckFraud).to have_received(:call).with(transaction_data:)
      end
    end
  end
end

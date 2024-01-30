# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransactionsController do
  describe 'POST /trasactions' do
    subject(:post_transaction) { post '/transactions', params:, as: :json }

    let(:params) do
      {
        transaction_id: 2_342_357,
        merchant_id: 29_744,
        user_id: 97_051,
        card_number: '434505******9116',
        transaction_date: Time.current,
        transaction_amount: 373,
        device_id: 285_475
      }
    end

    context 'when the transaction is above a certain amount in a given period' do
      before do
        params[:transaction_amount] = AntiFraudRules::HighAmountInPeriod::MAX_AMOUNT + 1
        params[:transaction_date] = params[:transaction_date].change(
          { hour: AntiFraudRules::HighAmountInPeriod::START_HOUR }
        )
      end

      it 'denies the transaction' do
        post_transaction

        expect(response).to have_http_status(:ok)
        expect(response.parsed_body).to eq(
          { recommendation: 'deny', transaction_id: params[:transaction_id] }.stringify_keys
        )
      end
    end

    context 'when user had a chargeback before' do
      before do
        create(:transaction, :chargebacked, user: create(:user, id: params[:user_id]))
      end

      it 'denies the transaction' do
        post_transaction

        expect(response).to have_http_status(:ok)
        expect(response.parsed_body).to eq(
          { recommendation: 'deny', transaction_id: params[:transaction_id] }.stringify_keys
        )
      end
    end

    context 'when user is trying too many transactions in a row' do
      before do
        create(
          :transaction,
          user: create(:user, id: params[:user_id]),
          created_at: (params[:transaction_date] - 1.second)
        )
      end

      it 'denies the transaction' do
        post_transaction

        expect(response).to have_http_status(:ok)
        expect(response.parsed_body).to eq(
          { recommendation: 'deny', transaction_id: params[:transaction_id] }.stringify_keys
        )
      end
    end

    context 'when transction does not violate ' \
            "#{CheckFraud::DEFAULT_RULES.map(&:name).map(&:demodulize).join(' or ')} rules" do
      before do
        params[:transaction_amount] = AntiFraudRules::HighAmountInPeriod::MAX_AMOUNT
        params[:transaction_date] = params[:transaction_date].change(
          { hour: AntiFraudRules::HighAmountInPeriod::START_HOUR - 1 }
        )
      end

      it 'approves the transaction' do
        post_transaction

        expect(response).to have_http_status(:ok)
        expect(response.parsed_body).to eq(
          { recommendation: 'approve', transaction_id: params[:transaction_id] }.stringify_keys
        )
      end
    end
  end
end

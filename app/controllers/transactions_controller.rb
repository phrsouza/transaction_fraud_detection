# frozen_string_literal: true

class TransactionsController < ApplicationController
  TRANSACTION_DATA_FIELDS = %i[
    transaction_id merchant_id user_id card_number transaction_date transaction_amount devide_id
  ].freeze

  api :POST, '/transactions'
  param :transaction_id, :number, desc: 'Transaction id', required: true, example: 2_342_357
  param :merchant_id, :number, desc: 'Merchant id', required: true, example: 29_744
  param :device_id, :number, desc: 'Device id', required: false, example: 285_475
  param :user_id, :number, desc: 'User id', required: true, example: 97_051
  param :card_number, String, desc: 'Anonymized credit card number', required: true, example: '434505******9116'
  param :transaction_date, String, desc: 'Transaction date in iso8601 format', required: true,
                                   example: '2024-01-31T00:39:13Z'
  param :transaction_amount, :decimal, desc: 'Transaction amount', required: true, example: 373.50
  returns code: 200, desc: 'Transaction id and anti fraud recommendation' do
    property :transaction_id, Integer, desc: 'Transaction id'
    property :recommendation, %w[approve deny], desc: 'Anti fraud recommendation'
  end
  def create
    render json: ProcessTransaction.call(transaction_data:)
  end

  private

  def transaction_data
    params.permit(
      *TRANSACTION_DATA_FIELDS
    ).merge(
      transaction_date: Time.zone.parse(params[:transaction_date])
    ).to_h.symbolize_keys
  end
end

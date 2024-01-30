# frozen_string_literal: true

class TransactionsController < ApplicationController
  TRANSACTION_DATA_FIELDS = %i[
    transaction_id merchant_id user_id card_number transaction_date transaction_amount devide_id
  ].freeze

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

# frozen_string_literal: true

module AntiFraudRules
  class UserPreviousChargeback < ApplicationService
    def initialize(transaction_data:)
      @transaction_data = transaction_data
    end

    def call
      user_previous_chargeback?
    end

    private

    def user_previous_chargeback?
      Transaction.where(
        user_id: @transaction_data[:user_id]
      ).where.not(
        chargebacked_at: nil
      ).exists?
    end
  end
end

# frozen_string_literal: true

module AntiFraudRules
  #
  # Service object to verify if the trasaction user had a chargeback previouly
  #
  class UserPreviousChargeback < ApplicationService
    def initialize(transaction_data:)
      @transaction_data = transaction_data
    end

    #
    # Method to verify if the transaction data violates the rule
    #
    # @return [Boolean] true if the transaction violates the rule, returns false otherwise
    #
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

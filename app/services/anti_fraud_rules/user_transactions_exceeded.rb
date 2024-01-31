# frozen_string_literal: true

module AntiFraudRules
  #
  # Service object to verify if the user requested a transaction right before requesting another
  #
  class UserTransactionsExceeded < ApplicationService
    CONFIG_NAMESPACE = name.demodulize.underscore.to_sym
    # @return [ActiveSupport::Duration] time interval to look for previous transactions.
    # Relative to the transaction date and configured in USER_TRANSACTIONS_EXCEEDED_TIME_INTERVAL env var
    TIME_INTERVAL = Rails.configuration.anti_fraud_rules.dig(CONFIG_NAMESPACE, :time_interval).seconds.freeze

    def initialize(transaction_data:)
      @transaction_data = transaction_data
    end

    #
    # Method to verify if the transaction data violates the rule
    #
    # @return [Boolean] true if the transaction violates the rule, returns false otherwise
    #
    def call
      user_transactions_exceeded?
    end

    private

    def user_transactions_exceeded?
      Transaction.exists?(
        user_id: @transaction_data[:user_id],
        created_at: TIME_INTERVAL.ago..@transaction_data[:transaction_date]
      )
    end
  end
end

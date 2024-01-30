# frozen_string_literal: true

module AntiFraudRules
  class UserTransactionsExceeded < ApplicationService
    CONFIG_NAMESPACE = name.demodulize.underscore.to_sym
    TIME_INTERVAL = Rails.configuration.anti_fraud_rules.dig(CONFIG_NAMESPACE, :time_interval).seconds.freeze

    def initialize(transaction_data:)
      @transaction_data = transaction_data
    end

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

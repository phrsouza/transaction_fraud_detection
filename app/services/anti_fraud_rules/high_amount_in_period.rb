# frozen_string_literal: true

module AntiFraudRules
  #
  # Service object to verify if a transaction amount is high given a configured period
  #
  class HighAmountInPeriod < ApplicationService
    CONFIG_NAMESPACE = name.demodulize.underscore.to_sym
    # @return [Integer] start hour of the observed period.
    # Configured in HIGH_AMOUNT_IN_PERIOD_START_HOUR env var
    START_HOUR = Rails.configuration.anti_fraud_rules.dig(CONFIG_NAMESPACE, :start_hour).freeze
    # @return [Integer] end hour of the observed period.
    # Configured in HIGH_AMOUNT_IN_PERIOD_END_HOUR env var
    END_HOUR = Rails.configuration.anti_fraud_rules.dig(CONFIG_NAMESPACE, :end_hour).freeze
    # @return [Decimal] max transaction amount for the overced period.
    # Configured in HIGH_AMOUNT_IN_PERIOD_MAX_AMOUNT env var
    MAX_AMOUNT = Rails.configuration.anti_fraud_rules.dig(CONFIG_NAMESPACE, :max_amount).freeze

    def initialize(transaction_data:)
      @transaction_data = transaction_data
    end

    #
    # Method to verify if the transaction data violates the rule
    #
    # @return [Boolean] true if the transaction violates the rule, returns false otherwise
    #
    def call
      high_amount_in_period?
    end

    private

    def high_amount_in_period?
      high_amount? && observed_period?
    end

    def high_amount?
      @transaction_data[:transaction_amount] > MAX_AMOUNT
    end

    def observed_period?
      transaction_date.between?(start_time, end_time)
    end

    def start_time
      transaction_date.change({ hour: START_HOUR })
    end

    def end_time
      flip_day? ? transaction_date.change({ hour: END_HOUR }).tomorrow : transaction_date.change({ hour: END_HOUR })
    end

    def flip_day?
      START_HOUR > END_HOUR
    end

    def transaction_date
      @transaction_date ||= @transaction_data[:transaction_date]
    end
  end
end

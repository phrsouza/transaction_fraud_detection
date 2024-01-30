# frozen_string_literal: true

class CheckFraud < ApplicationService
  DEFAULT_RULES = [
    AntiFraudRules::HighAmountInPeriod,
    AntiFraudRules::UserPreviousChargeback,
    AntiFraudRules::UserTransactionsExceeded
  ].freeze

  def initialize(transaction_data:, rules: DEFAULT_RULES)
    @transaction_data = transaction_data
    @rules = rules
  end

  def call
    fraud?
  end

  def fraud?
    lazy_rules_evaluator = @rules.lazy.map do |rule|
      rule.call(transaction_data: @transaction_data)
    end

    lazy_rules_evaluator.find { |rule_result| rule_result == true }.present?
  end
end

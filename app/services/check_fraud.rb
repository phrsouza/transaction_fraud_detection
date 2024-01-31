# frozen_string_literal: true

#
# Service object to check for frauds based on a set of rules
#
class CheckFraud < ApplicationService
  # @return [Array<Class>] A list of classes that implement each default rule
  DEFAULT_RULES = [
    AntiFraudRules::HighAmountInPeriod,
    AntiFraudRules::UserPreviousChargeback,
    AntiFraudRules::UserTransactionsExceeded
  ].freeze

  def initialize(transaction_data:, rules: DEFAULT_RULES)
    @transaction_data = transaction_data
    @rules = rules
  end

  #
  # Method to execute the set of rules against the transaction data
  #
  # @return [Boolean] true if the transaction violates any of the rules, false otherwise
  #
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

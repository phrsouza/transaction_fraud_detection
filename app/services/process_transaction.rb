# frozen_string_literal: true

class ProcessTransaction < ApplicationService
  def initialize(transaction_data:)
    @transaction_data = transaction_data
  end

  def call
    response
  end

  private

  def response
    {
      recommendation: (fraud? ? 'deny' : 'approve'),
      transaction_id: @transaction_data[:transaction_id]
    }
  end

  def fraud?
    return @fraud if defined? @fraud

    @fraud = CheckFraud.call(transaction_data: @transaction_data)
  end
end

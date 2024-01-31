# frozen_string_literal: true

#
# Service object to process a transaction and format the response
#
class ProcessTransaction < ApplicationService
  def initialize(transaction_data:)
    @transaction_data = transaction_data
  end

  #
  # Method to get the systems recommendation about the transaction recommendations and format the response
  #
  # @return [Hash{Symbol => String}] A hash containg the :transaction_id and the system's recommedation,
  # which can be "approve" or "deny"
  #
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

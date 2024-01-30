# frozen_string_literal: true

class ImportTransactions
  CSV_OPTIONS = {
    converters: %i[integer float date_time], headers: true
  }.freeze

  def self.call(file_path:)
    new(file_path:).call
  end

  def initialize(file_path:)
    @file_path = file_path
  end

  def call
    import_transactions
  end

  private

  def import_transactions
    CSV.foreach(@file_path, **CSV_OPTIONS) do |row|
      create_transaction(row)
    end
  end

  def create_transaction(row)
    Transaction.create!(transaction_data(row))
  end

  def transaction_data(row)
    {
      merchant: merchant(row['merchant_id']),
      device: device(row['device_id']),
      user: user(row['user_id']),
      id: row['transaction_id'],
      amount: row['transaction_amount'],
      created_at: row['transaction_date'],
      card_number: row['card_number'],
      chargebacked_at: (Time.current if row['has_cbk'] == 'TRUE')
    }.compact
  end

  def merchant(merchant_id)
    Merchant.find_or_create_by(id: merchant_id)
  end

  def user(user_id)
    User.find_or_create_by(id: user_id)
  end

  def device(device_id)
    return nil if device_id.blank?

    Device.find_or_create_by(id: device_id)
  end
end

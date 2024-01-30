# frozen_string_literal: true

require 'csv'

class ImportDbFromCsv < ActiveRecord::Migration[7.1]
  def up
    # transaction_sample = CSV.parse(
    #   File.read('db/data/transactional_sample.csv', headers: true),
    #   converters: %i[integer float date_time]
    # )

    CSV.foreach('db/data/transactional_sample.csv', converters: %i[integer float date_time], headers: true) do |row|
      merchant = Merchant.find_or_create_by(id: row['merchant_id'])
      device = row['device_id'].present? ? Device.find_or_create_by(id: row['device_id']) : nil
      user = User.find_or_create_by(id: row['user_id'])

      Transaction.create!(
        {
          merchant:,
          device:,
          user:,
          id: row['transaction_id'],
          amount: row['transaction_amount'],
          created_at: row['transaction_date'],
          card_number: row['card_number'],
          chargebacked_at: (Time.now if row['has_cbk'] == 'TRUE')
        }.compact
      )
    end
  end

  def down
    Transaction.delete_all
    Merchant.delete_all
    Device.delete_all
    User.delete_all
  end
end

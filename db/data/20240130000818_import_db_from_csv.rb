# frozen_string_literal: true

require 'csv'

class ImportDbFromCsv < ActiveRecord::Migration[7.1]
  def up
    ImportTransactions.call(file_path: 'db/data/transactional_sample.csv')

    ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
  end

  def down
    Transaction.delete_all
    Merchant.delete_all
    Device.delete_all
    User.delete_all
  end
end

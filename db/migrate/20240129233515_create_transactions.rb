# frozen_string_literal: true

class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.string :card_number, null: false
      t.datetime :chargebacked_at, default: nil
      t.decimal :amount, precision: 8, scale: 2, null: false
      t.references :device, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :merchant, null: false, foreign_key: true

      t.timestamps
    end
  end
end

# frozen_string_literal: true

class CreateSamples < ActiveRecord::Migration[7.1]
  def change
    create_table :samples do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end

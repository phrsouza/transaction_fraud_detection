# frozen_string_literal: true

class CreateDevices < ActiveRecord::Migration[7.1]
  def change
    create_table :devices, &:timestamps
  end
end

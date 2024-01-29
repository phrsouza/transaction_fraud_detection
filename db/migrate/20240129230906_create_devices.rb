class CreateDevices < ActiveRecord::Migration[7.1]
  def change
    create_table :devices do |t|

      t.timestamps
    end
  end
end

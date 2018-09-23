class CreatePoolReadings < ActiveRecord::Migration[5.0]
  def change
    create_table :pool_readings do |t|
      t.decimal :user_rate
      t.integer :workers
      t.timestamps
    end
  end
end

class CreateWorkerReadings < ActiveRecord::Migration[5.0]
  def change
    create_table :worker_readings do |t|
      t.integer :worker_id
      t.decimal :rate
      t.boolean :alive
      t.timestamps
    end
  end
end

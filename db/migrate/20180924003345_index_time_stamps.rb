class IndexTimeStamps < ActiveRecord::Migration[5.0]
  def change
    add_index :worker_readings, :created_at
    add_index :pool_readings, :created_at
    add_index :worker_readings, :alive
    add_index :worker_readings, :rate
  end
end

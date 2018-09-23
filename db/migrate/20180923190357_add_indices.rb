class AddIndices < ActiveRecord::Migration[5.0]
  def change
    add_index :workers, :name, unique: true
    add_index :worker_readings, :worker_id
  end
end

class RenamePoolReadingRate < ActiveRecord::Migration[5.0]
  def change
    rename_column :pool_readings, :user_rate, :rate
  end
end

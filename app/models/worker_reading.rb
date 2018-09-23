class WorkerReading < ApplicationRecord
  belongs_to :worker, inverse_of: :worker_readings
end

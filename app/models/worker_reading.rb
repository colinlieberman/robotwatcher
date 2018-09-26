class WorkerReading < ApplicationRecord
  belongs_to :worker, inverse_of: :worker_readings
  default_scope { order(:created_at) }
end

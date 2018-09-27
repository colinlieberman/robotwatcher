class WorkerReading < ApplicationRecord
  scope :ordered, -> { order(:created_at) }
  belongs_to :worker, inverse_of: :worker_readings
end

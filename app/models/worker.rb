class Worker < ApplicationRecord
  has_many :worker_readings, inverse_of: :worker
end
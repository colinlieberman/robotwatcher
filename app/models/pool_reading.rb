class PoolReading < ApplicationRecord
  scope :ordered, -> { order(:created_at) }

  class <<self
    include Statsable
  end
end

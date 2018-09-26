class PoolReading < ApplicationRecord
  default_scope { order(:created_at) }

  class <<self
    include Statsable
  end
end

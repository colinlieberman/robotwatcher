class Worker < ApplicationRecord
  has_many :worker_readings, inverse_of: :worker
  include Statsable

  def graph
    Grapher.day_graph name, "#{name} Thps"
  end
end

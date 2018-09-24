class PoolReading < ApplicationRecord
  class <<self
    include Statsable
    def graph
      Grapher.day_graph "total", "Total Thps Among all Workers"
    end
  end
end

class PoolReading < ApplicationRecord
  class <<self
    include Statsable
    def graph
      Grapher.day_graph "total", "Total Thps Among all Workers"
    end

    def mean_all_time
      @@mean_all_time ||= number_format PoolReading.all.average(:user_rate)
    end

    def mean_all_uptime
      @@mean_all_uptime ||= number_format PoolReading.where("user_rate > 0").average(:user_rate)
    end
  end
end

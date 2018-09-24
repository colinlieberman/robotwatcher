module Statsable
  include ActiveSupport::Concern
  def pct_uptime_since(date)
    minutes_up = self.where("user_rate > 0").where("created_at >= '#{date}'").count.to_f
    total_minutes = self.where("created_at > '#{date}'").count.to_f
    number_format((minutes_up / total_minutes) * 100)
  end

  def number_format(val)
    val.round(2).to_f
  end
end

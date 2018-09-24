module Statsable
  include ActiveSupport::Concern
  def pct_uptime_since(date)
    minutes_up = target.where("rate > 0").where("created_at >= '#{date}'").count.to_f
    total_minutes = target.where("created_at >= '#{date}'").count.to_f
    number_format((minutes_up / total_minutes) * 100)
  end

  def pct_uptime
    minutes_up = target.where("rate > 0").count.to_f
    total_minutes = target.count.to_f
    number_format((minutes_up / total_minutes) * 100)
  end

  def current_rate
    number_format target.order("created_at DESC").limit(1).first.rate
  end

  def mean_since(date)
    number_format target.where("created_at >= '#{date}'").average(:rate)
  end

  def uptime_mean_since(date)
    number_format target.where("rate > 0").where("created_at >= '#{date}'").average(:rate)
  end

  def mean_all_time
    number_format target.all.average(:rate)
  end

  def mean_all_uptime
    number_format target.where("rate > 0").average(:rate)
  end

  def max_all_time
    number_format target.maximum("rate")
  end

  def max_since(date)
    number_format target.where("created_at >= '#{date}'").maximum("rate")
  end

  private

  def number_format(val)
    val.round(2).to_f
  end

  def target
    self.class.name == "Worker" ? self.worker_readings : self
  end
end

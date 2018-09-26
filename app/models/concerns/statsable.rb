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

  def all_since(time)
    target.where("created_at >= '#{time}'")
  end

  def number_format(val)
    return 0 unless val
    val.round(2).to_f
  end

  def stats
    {
      uptime: {
        hour:  pct_uptime_since(TimeHelper.hour),
        day:   pct_uptime_since(TimeHelper.day),
        week:  pct_uptime_since(TimeHelper.week),
        month: pct_uptime_since(TimeHelper.month),
        year:  pct_uptime_since(TimeHelper.year),
        all:   pct_uptime
      }, tthps: {
        current: current_rate,
        hour:    mean_since(TimeHelper.hour),
        day:     mean_since(TimeHelper.day),
        week:    mean_since(TimeHelper.week),
        month:   mean_since(TimeHelper.month),
        year:    mean_since(TimeHelper.year),
        all:     mean_all_time
      }, uthps: {
        hour:  uptime_mean_since(TimeHelper.hour),
        day:   uptime_mean_since(TimeHelper.day),
        week:  uptime_mean_since(TimeHelper.week),
        month: uptime_mean_since(TimeHelper.month),
        year:  uptime_mean_since(TimeHelper.year),
        all:   mean_all_uptime
      }, max: {
        hour:   max_since(TimeHelper.hour),
        day:    max_since(TimeHelper.day),
        week:   max_since(TimeHelper.week),
        month:  max_since(TimeHelper.month),
        year:   max_since(TimeHelper.year),
        all:    max_all_time
      }
    }
  end

  private

  def target
    self.class.name == "Worker" ? self.worker_readings : self
  end
end

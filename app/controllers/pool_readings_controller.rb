class PoolReadingsController < ApplicationController
  helper_method :chart_data

  def index
    @df = `ssh -p2222 tombstone -- "df -h"`
  end

  def chart_data
    chart_data = {
      pool_data: PoolReading::all_since(TimeHelper.day).map do |reading|
        { rate: PoolReading::number_format(reading.rate),
          time: reading.created_at.strftime("%Y-%m-%d %H:%I:%S") }
      end,
      workers: {}
    }
    Worker.all.each do |worker|
      chart_data[:workers][worker.name] = worker.all_since(TimeHelper.day).map do |reading|
        { rate: PoolReading::number_format(reading.rate),
          time: reading.created_at.strftime("%Y-%m-%d %H:%I:%S") }
      end
    end
    chart_data
  end
end

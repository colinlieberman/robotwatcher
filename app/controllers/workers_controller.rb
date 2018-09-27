class WorkersController < ApplicationController
  def show
    render json: chart_data
  end

  def stats
    render json: worker::stats
  end

  def chart_data
    worker::all_since(TimeHelper.day).map do |reading|
      { rate: PoolReading::number_format(reading.rate),
        time: reading.created_at.strftime("%Y-%m-%d %H:%M:%S") }
    end
  end

  def worker
    Worker.find(params[:id])
  end
end

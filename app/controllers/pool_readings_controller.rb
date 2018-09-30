class PoolReadingsController < ApplicationController
  helper_method :empty_watcher

  def index
    @workers = Worker.all
    respond_to do |format|
      format.html
      format.json { render json: chart_data }
    end
  end

  def empty_watcher
    watcher = {pool_data: [], workers: {}}
    Worker.all.each do |worker|
      watcher[:workers][worker.id] = []
    end
    watcher
  end

  def stats
    render json: PoolReading::stats
  end

  # really this should be its own controller, but I'm so lazy
  def df
    render text: `#{Rails.application.secrets.db_df_command}`
  end

  def chart_data
    PoolReading::all_since(TimeHelper.day).map do |reading|
      { rate: PoolReading::number_format(reading.rate),
        time: reading.created_at.strftime("%Y-%m-%d %H:%M:%S") }
    end
  end
end

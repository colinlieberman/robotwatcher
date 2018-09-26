class PoolReadingsController < ApplicationController
  helper_method :empty_watcher

  def index
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

  def df
    render text: `ssh -p2222 tombstone -- "df -h"`
  end

  def chart_data
    PoolReading::all_since(TimeHelper.day).map do |reading|
      { rate: PoolReading::number_format(reading.rate),
        time: reading.created_at.strftime("%Y-%m-%d %H:%I:%S") }
    end
  end
end

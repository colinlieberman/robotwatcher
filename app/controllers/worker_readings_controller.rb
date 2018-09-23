class WorkerReadingsController < ApplicationController
  before_action :set_worker_reading, only: [:show, :edit, :update, :destroy]

  # GET /worker_readings
  def index
    @worker_readings = WorkerReading.all
  end

  # GET /worker_readings/1
  def show
  end

  # GET /worker_readings/new
  def new
    @worker_reading = WorkerReading.new
  end

  # GET /worker_readings/1/edit
  def edit
  end

  # POST /worker_readings
  def create
    @worker_reading = WorkerReading.new(worker_reading_params)

    if @worker_reading.save
      redirect_to @worker_reading, notice: 'Worker reading was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /worker_readings/1
  def update
    if @worker_reading.update(worker_reading_params)
      redirect_to @worker_reading, notice: 'Worker reading was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /worker_readings/1
  def destroy
    @worker_reading.destroy
    redirect_to worker_readings_url, notice: 'Worker reading was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_worker_reading
      @worker_reading = WorkerReading.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def worker_reading_params
      params.require(:worker_reading).permit(:rate, :worker_id)
    end
end

class PoolReadingsController < ApplicationController
  before_action :set_pool_reading, only: [:show, :edit, :update, :destroy]

  # GET /pool_readings
  def index
    @pool_readings = PoolReading.all
  end

  # GET /pool_readings/1
  def show
  end

  # GET /pool_readings/new
  def new
    @pool_reading = PoolReading.new
  end

  # GET /pool_readings/1/edit
  def edit
  end

  # POST /pool_readings
  def create
    @pool_reading = PoolReading.new(pool_reading_params)

    if @pool_reading.save
      redirect_to @pool_reading, notice: 'Pool reading was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /pool_readings/1
  def update
    if @pool_reading.update(pool_reading_params)
      redirect_to @pool_reading, notice: 'Pool reading was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /pool_readings/1
  def destroy
    @pool_reading.destroy
    redirect_to pool_readings_url, notice: 'Pool reading was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pool_reading
      @pool_reading = PoolReading.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def pool_reading_params
      params.fetch(:pool_reading, {})
    end
end

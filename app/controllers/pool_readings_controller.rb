class PoolReadingsController < ApplicationController
  before_action :set_pool_reading, only: [:show, :edit, :update, :destroy]

  def index
    @graph_path = PoolReading.graph
    @workers = {}
    Worker.all.each do |w|
      @workers[w.name] = w.graph
    end
  end
end

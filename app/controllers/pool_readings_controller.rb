class PoolReadingsController < ApplicationController
  before_action :set_pool_reading, only: [:show, :edit, :update, :destroy]
end

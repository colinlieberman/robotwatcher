class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :clear_active_record_query_cache

  def clear_active_record_query_cache
    ActiveRecord::Base.connection.clear_query_cache
  end
end

class Worker < ApplicationRecord
  has_many :worker_readings, inverse_of: :worker
  include Statsable

  def month_summary
    prepare_month
    con.exec_prepared("month_stats", [id])
  end

  private

  def prepare_month
    begin
      con.prepare("month_stats", "
        WITH
          day_intervals AS (SELECT GENERATE_SERIES(0, 30) AS day_interval),
          day_endings AS (SELECT NOW() - (day_interval || ' days')::INTERVAL AS day_end FROM day_intervals)

        SELECT TO_CHAR(d.day_end, 'yyyy-mm-dd') AS time, TO_CHAR(AVG(w.rate), 'FM90D99') AS rate
          FROM worker_readings w
          JOIN day_endings d ON w.created_at <= d.day_end AND w.created_at > (d.day_end - INTERVAL '1 day')
          WHERE w.worker_id = $1
          GROUP BY d.day_end
          ORDER BY day_end ASC")
    rescue PG::DuplicatePstatement
      # statement exists, so don't worry
    end
  end
end

class TimeHelper
  class <<self
    def now
      DateTime.now
    end

    def hour
      now - 1.hour
    end

    def day
      now - 24.hours
    end

    def week
      now - 7.days
    end

    def month
      now - 1.month
    end

    def year
      now - 1.year
    end
  end
end

class TimeHelper
  class <<self
    def now
      @@now ||= DateTime.now
    end

    def hour
      @@hour ||= now - 1.hour
    end

    def day
      @@day ||= now - 24.hours
    end

    def week
      @@week ||= now - 7.days
    end

    def month
      @@month ||= now - 1.month
    end

    def year
      @@year ||= now - 1.year
    end
  end
end

require 'month_weeks/week'

module MonthWeeks
  class Month
    attr_reader :first_day_of_week

    public
    def initialize(*args)
      options = args.last.kind_of?(Hash) ? args.pop : {}

      if args.length == 2
        year, month = args
        @init_date = Date.new(year, month)
      elsif args.length == 1
        date = args.first
        @init_date = Date.parse(date)
      else
        raise ArgumentError.new("wrong number of arguments (0 for 1..3)")
      end

      @first_day_of_week = options[:first_day_of_week] || 1
    end

    def year
      init_date.year
    end

    def month
      init_date.month
    end

    def weeks
      current = first
      weeks = []
      while (current <= last) do
        start_date = current
        end_date = day_to_date(end_of_week(start_date))
        weeks << Week.new(start_date, end_date)
        current = end_date.next
      end
      weeks
    end

    def first
      day_to_date(1)
    end

    def last
      day_to_date(days)
    end

    def last_day_of_week
      (first_day_of_week + 6) % 7
    end

    def days
      case month
      when 1, 3, 5, 7, 8, 10, 12
        31
      when 4, 6, 9, 11
        30
      when 2
        Date.leap?(year) ? 29 : 28
      end
    end

    def to_h
      { :year => year, :month => month, :first => first, :last => last,
        :weeks => weeks
      }
    end

    def to_json(*args)
      self.to_h.to_json(*args)
    end

    def to_s
      sprintf("%d-%02d", year, month)
    end

    private
    attr_reader :init_date

    def end_of_week(start_of_week)
      if start_of_week == first
        if last_day_of_week == start_of_week.wday
          return start_of_week
        else
          return start_of_week + (7 - start_of_week.wday)
        end
      end

      [last, start_of_week + 6].min
    end

    def day_to_date(dayOrDate)
      day = dayOrDate.respond_to?(:mday) ? dayOrDate.mday : dayOrDate
      Date.new(year, month, day)
    end
  end
end

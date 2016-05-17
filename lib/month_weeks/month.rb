require 'month_weeks/week'

module MonthWeeks
  class Month
    private
    attr_reader :init_date

    public
    def initialize(date)
      @init_date = Date.parse(date)
    end

    def year
      init_date.year
    end

    def month
      init_date.month
    end

    def weeks
      week = Week.new(Date.new(year, month, 1), Date.new(year, month, 1))
      [week, 1, 2, 3, 4]
    end
  end
end

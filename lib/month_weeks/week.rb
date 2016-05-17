require 'json'

module MonthWeeks
  class Week
    attr_reader :start_date, :end_date
    def initialize(start_date, end_date)
      @start_date = start_date
      @end_date = end_date
    end

    def dates
      @dates ||= start_date.step(end_date).to_a
    end

    def to_h
       { :start_date => start_date, :end_date => end_date, :dates => dates }
    end

    def to_json(*args)
      self.to_h.to_json(*args)
    end
  end
end

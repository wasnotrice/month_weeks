require 'spec_helper'

describe MonthWeeks do
  specify 'has a version number' do
    expect(MonthWeeks::VERSION).not_to be nil
  end
end

module ExpectationGenerators
  def describeWeek(month_weeks, options)
    week_index = options.fetch(:week)
    start_date_string = options.fetch(:start_date)
    end_date_string = options.fetch(:end_date)

    describe "week #{week_index}" do
      let (:week) { month_weeks.weeks[week_index] }
      it "starts on #{start_date_string}" do
        expect(week.start_date).to eq(Date.parse(start_date_string))
      end

      it "ends on #{end_date_string}" do
        expect(week.end_date).to eq(Date.parse(end_date_string))
      end
    end
  end

  def describeMonth(month_weeks, options)
    year = options.fetch(:year)
    month = options.fetch(:month)
    first = options.fetch(:first)
    last = options.fetch(:last)
    first_padded = sprintf('%02d', first)
    last_padded = sprintf('%02d', last)
    weeks = options.fetch(:weeks)

    specify "year is #{year}" do
      expect(month_weeks.year).to eq(year)
    end

    specify "month is #{month}" do
      expect(month_weeks.month).to eq(month)
    end

    specify "first is 2015-02-#{first_padded}" do
      expect(month_weeks.first).to eq(Date.new(year, month, first))
    end

    specify "last is 2015-02-#{last_padded}" do
      expect(month_weeks.last).to eq(Date.new(year, month, last))
    end

    specify "has 5 weeks" do
      expect(month_weeks.weeks.length).to eq(weeks)
    end
  end

  def describeConfig(month_weeks, options)
    first_day_of_week = options.fetch(:first_day_of_week)
    last_day_of_week = options.fetch(:last_day_of_week)

    specify "first_day_of_week is #{first_day_of_week}" do
      expect(month_weeks.first_day_of_week).to eq(first_day_of_week)
    end

    specify "last_day_of_week is #{last_day_of_week}" do
      expect(month_weeks.last_day_of_week).to eq(last_day_of_week)
    end
  end
end

describe 'May 2016' do
  extend ExpectationGenerators
  month = MonthWeeks::Month.new('2016-05-15')

  describeMonth(month, year: 2016, month: 5, first: 1, last: 31, weeks: 6)
  describeConfig(month, first_day_of_week: 1, last_day_of_week: 0)
  describeWeek(month, week: 0, start_date: '2016-05-01', end_date: '2016-05-01')
  describeWeek(month, week: 1, start_date: '2016-05-02', end_date: '2016-05-08')
  describeWeek(month, week: 2, start_date: '2016-05-09', end_date: '2016-05-15')
  describeWeek(month, week: 3, start_date: '2016-05-16', end_date: '2016-05-22')
  describeWeek(month, week: 4, start_date: '2016-05-23', end_date: '2016-05-29')
  describeWeek(month, week: 5, start_date: '2016-05-30', end_date: '2016-05-31')
end

describe 'February 2016' do
  extend ExpectationGenerators
  month = MonthWeeks::Month.new('2016-02-03')

  describeMonth(month, year: 2016, month: 2, first: 1, last: 29, weeks: 5)
  describeConfig(month, first_day_of_week: 1, last_day_of_week: 0)
  describeWeek(month, week: 0, start_date: '2016-02-01', end_date: '2016-02-07')
  describeWeek(month, week: 1, start_date: '2016-02-08', end_date: '2016-02-14')
  describeWeek(month, week: 2, start_date: '2016-02-15', end_date: '2016-02-21')
  describeWeek(month, week: 3, start_date: '2016-02-22', end_date: '2016-02-28')
  describeWeek(month, week: 4, start_date: '2016-02-29', end_date: '2016-02-29')
end

describe "March 2016" do
  extend ExpectationGenerators
  month = MonthWeeks::Month.new('2016-03-30')

  describeMonth(month, year: 2016, month: 3, first: 1, last: 31, weeks: 5)
  describeConfig(month, first_day_of_week: 1, last_day_of_week: 0)
  describeWeek(month, week: 0, start_date: '2016-03-01', end_date: '2016-03-06')
  describeWeek(month, week: 1, start_date: '2016-03-07', end_date: '2016-03-13')
  describeWeek(month, week: 2, start_date: '2016-03-14', end_date: '2016-03-20')
  describeWeek(month, week: 3, start_date: '2016-03-21', end_date: '2016-03-27')
  describeWeek(month, week: 4, start_date: '2016-03-28', end_date: '2016-03-31')
end

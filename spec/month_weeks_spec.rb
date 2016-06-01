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
    month_padded = sprintf('%02d', month)
    weeks = options.fetch(:weeks)

    specify "year is #{year}" do
      expect(month_weeks.year).to eq(year)
    end

    specify "month is #{month}" do
      expect(month_weeks.month).to eq(month)
    end

    specify "first is #{year}-#{month}-#{first_padded}" do
      expect(month_weeks.first).to eq(Date.new(year, month, first))
    end

    specify "last is #{year}-#{month}-#{last_padded}" do
      expect(month_weeks.last).to eq(Date.new(year, month, last))
    end

    it "has #{weeks} weeks" do
      expect(month_weeks.weeks.length).to eq(weeks)
    end

    specify "string representation is '#{year}-#{month_padded}'" do
      expect(month_weeks.to_s).to eq("#{year}-#{month_padded}")
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

  describe 'dates of weeks' do
    let(:weeks) { month.weeks }
    specify 'week 3 contains 16-22' do
      dates = weeks[3].dates
      expected_dates = (16..22).map { |day| Date.parse("2016-05-#{day}") }
      expect(dates.size).to eq(7)
      expect(dates).to eq(expected_dates)
    end
  end

  describe 'converting to JSON' do
    let (:weeks_json) {
      %q([
        {
          "start_date": "2016-05-01",
          "end_date": "2016-05-01",
          "dates": [ "2016-05-01" ]
        },
        {
          "start_date": "2016-05-02",
          "end_date": "2016-05-08",
          "dates": ["2016-05-02", "2016-05-03", "2016-05-04", "2016-05-05", "2016-05-06", "2016-05-07", "2016-05-08" ]
        },
        {
          "start_date": "2016-05-09",
          "end_date": "2016-05-15",
          "dates": [ "2016-05-09", "2016-05-10", "2016-05-11", "2016-05-12", "2016-05-13", "2016-05-14", "2016-05-15" ]
         },
        {
          "start_date": "2016-05-16",
          "end_date": "2016-05-22",
          "dates": [ "2016-05-16", "2016-05-17", "2016-05-18", "2016-05-19", "2016-05-20", "2016-05-21", "2016-05-22" ]
        },
        {
          "start_date": "2016-05-23",
          "end_date": "2016-05-29",
          "dates": [ "2016-05-23", "2016-05-24", "2016-05-25", "2016-05-26", "2016-05-27", "2016-05-28", "2016-05-29" ]
        },
        {
          "start_date": "2016-05-30",
          "end_date": "2016-05-31",
          "dates": [ "2016-05-30", "2016-05-31"]
        }
      ])
    }
    it 'converts weeks to JSON' do
      expected_json = weeks_json
      generated_json = JSON.generate(month.weeks)
      expect(JSON.parse(generated_json)).to eq(JSON.parse(expected_json))
    end

    it 'converts to JSON' do
      expected_json = %Q({
        "year": 2016,
        "month": 5,
        "first": "2016-05-01",
        "last": "2016-05-31",
        "weeks": #{weeks_json}
      })
      generated_json = JSON.generate(month)
      expect(JSON.parse(generated_json)).to eq(JSON.parse(expected_json))
    end
  end
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

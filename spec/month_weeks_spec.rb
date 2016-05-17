require 'spec_helper'

describe MonthWeeks do
  specify 'has a version number' do
    expect(MonthWeeks::VERSION).not_to be nil
  end
end

describe 'May 2016' do
  let(:month) { MonthWeeks::Month.new('2016-05-15') }
  specify 'year is 2016' do
    expect(month.year).to eq(2016)
  end

  specify 'month is 5' do
    expect(month.month).to eq(5)
  end

  specify 'first is 2015-05-01' do
    expect(month.first).to eq(Date.new(2016, 5, 1))
  end

  specify 'last is 2015-05-31' do
    expect(month.last).to eq(Date.new(2016, 5, 31))
  end

  specify 'first_day_of_week is 1' do
    expect(month.first_day_of_week).to eq(1)
  end

  specify 'last_day_of_week is 0' do
    expect(month.last_day_of_week).to eq(0)
  end

  specify 'has 6 weeks' do
    expect(month.weeks.length).to eq(6)
  end

  describe 'week 0' do
    let (:week) { month.weeks[0] }
    it 'starts on 2016-05-01' do
      expect(week.start_date).to eq(Date.new(2016, 5, 1))
    end

    it 'ends on 2016-05-01' do
      expect(week.end_date).to eq(Date.new(2016, 5, 1))
    end
  end

  describe 'week 1' do
    let (:week) { month.weeks[1]}
    it 'starts on 2016-05-02' do
      expect(week.start_date).to eq(Date.new(2016, 5, 2))
    end

    it 'ends on 2016-05-08' do
      expect(week.end_date).to eq(Date.new(2016, 5, 8))
    end
  end

  describe 'week 2' do
    let (:week) { month.weeks[2]}
    it 'starts on 2016-05-09' do
      expect(week.start_date).to eq(Date.new(2016, 5, 9))
    end

    it 'ends on 2016-05-15' do
      expect(week.end_date).to eq(Date.new(2016, 5, 15))
    end
  end

  describe 'week 3' do
    let (:week) { month.weeks[3]}
    it 'starts on 2016-05-16' do
      expect(week.start_date).to eq(Date.new(2016, 5, 16))
    end

    it 'ends on 2016-05-22' do
      expect(week.end_date).to eq(Date.new(2016, 5, 22))
    end
  end

  describe 'week 4' do
    let (:week) { month.weeks[4]}
    it 'starts on 2016-05-23' do
      expect(week.start_date).to eq(Date.new(2016, 5, 23))
    end

    it 'ends on 2016-05-29' do
      expect(week.end_date).to eq(Date.new(2016, 5, 29))
    end
  end

  describe 'week 5' do
    let (:week) { month.weeks[5]}
    it 'starts on 2016-05-30' do
      expect(week.start_date).to eq(Date.new(2016, 5, 30))
    end

    it 'ends on 2016-05-31' do
      expect(week.end_date).to eq(Date.new(2016, 5, 31))
    end
  end
end

describe 'February 2016' do
  let(:month) { MonthWeeks::Month.new('2016-02-03') }
  specify 'year is 2016' do
    expect(month.year).to eq(2016)
  end

  specify 'month is 2' do
    expect(month.month).to eq(2)
  end

  specify 'first is 2015-02-01' do
    expect(month.first).to eq(Date.new(2016, 2, 1))
  end

  specify 'last is 2015-02-29' do
    expect(month.last).to eq(Date.new(2016, 2, 29))
  end

  specify 'first_day_of_week is 1' do
    expect(month.first_day_of_week).to eq(1)
  end

  specify 'last_day_of_week is 0' do
    expect(month.last_day_of_week).to eq(0)
  end

  specify 'has 5 weeks' do
    expect(month.weeks.length).to eq(5)
  end

  describe 'week 0' do
    let (:week) { month.weeks[0] }
    it 'starts on 2016-02-01' do
      expect(week.start_date).to eq(Date.new(2016, 2, 1))
    end

    it 'ends on 2016-02-07' do
      expect(week.end_date).to eq(Date.new(2016, 2, 7))
    end
  end

  describe 'week 1' do
    let (:week) { month.weeks[1]}
    it 'starts on 2016-02-08' do
      expect(week.start_date).to eq(Date.new(2016, 2, 8))
    end

    it 'ends on 2016-02-14' do
      expect(week.end_date).to eq(Date.new(2016, 2, 14))
    end
  end

  describe 'week 2' do
    let (:week) { month.weeks[2]}
    it 'starts on 2016-02-15' do
      expect(week.start_date).to eq(Date.new(2016, 2, 15))
    end

    it 'ends on 2016-02-21' do
      expect(week.end_date).to eq(Date.new(2016, 2, 21))
    end
  end

  describe 'week 3' do
    let (:week) { month.weeks[3]}
    it 'starts on 2016-02-22' do
      expect(week.start_date).to eq(Date.new(2016, 2, 22))
    end

    it 'ends on 2016-02-29' do
      expect(week.end_date).to eq(Date.new(2016, 2, 28))
    end
  end

  describe 'week 4' do
    let (:week) { month.weeks[4]}
    it 'starts on 2016-02-29' do
      expect(week.start_date).to eq(Date.new(2016, 2, 29))
    end

    it 'ends on 2016-02-29' do
      expect(week.end_date).to eq(Date.new(2016, 2, 29))
    end
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

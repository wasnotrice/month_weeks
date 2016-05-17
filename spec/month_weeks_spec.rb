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
    it 'starts on 2016-05-016' do
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

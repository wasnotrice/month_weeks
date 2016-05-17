require 'spec_helper'

describe MonthWeeks do
  it 'has a version number' do
    expect(MonthWeeks::VERSION).not_to be nil
  end
end

describe 'May 2016' do
  let(:month) { MonthWeeks::Month.new('2016-05-15') }
  it 'has year 2016' do
    expect(month.year).to eq(2016)
  end

  it 'has month 5' do
    expect(month.month).to eq(5)
  end

  it 'has 5 weeks' do
    expect(month.weeks.length).to eq(5)
  end

  describe 'week 0' do
    let (:week) { month.weeks.first }
    it 'starts on 2016-05-01' do
      expect(week.start_date).to eq(Date.new(2016, 5, 1))
    end
  end
end

# Task 1: Banking Day Offset
# Submitted by: Lee Johnson
# 
# You are given a start date and offset counter. Optionally you also get bank holiday date list.
# 
# Given a number (of days) and a start date, return the number (of days) adjusted to take into account non-banking days. In other words: convert a banking day offset to a calendar day offset.
# 
# Non-banking days are:
# a) Weekends
# b) Bank holidays
# 
# Example 1
# Input: $start_date = '2018-06-28', $offset = 3, $bank_holidays = ['2018-07-03']
# Output: '2018-07-04'
# 
# Thursday bumped to Wednesday (3 day offset, with Monday a bank holiday)
# 
# Example 2
# Input: $start_date = '2018-06-28', $offset = 3
# Output: '2018-07-03'

defmodule BankingDay do

  def banking_day_offset(start_date, offset, bank_holidays) do
    out(start_date, offset, bank_holidays,
        next_working_day( Date.from_iso8601!(start_date), offset, bank_holidays)
       )
  end

  def next_working_day(dt, offset, bank_holidays) when offset > 0 do
    dt1 = Date.add(dt, 1)
    if Date.day_of_week(dt1) >= 6 || Enum.member?(bank_holidays, "#{dt1}") do
        next_working_day(dt1, offset, bank_holidays)
    else
        next_working_day(dt1, offset-1, bank_holidays)
    end
  end

 def next_working_day(dt, 0, _bank_holidays) do
    Date.to_iso8601(dt)
  end

  def out(start_date, offset, bank_holidays, ymd) do
    IO.write( "(start #{start_date} offset #{offset} Bank holidays [" <> Enum.join(bank_holidays, ", ") <> "]) -> ")
    IO.puts( ymd )
  end
end

start_date = "2018-06-28"
offset = 3
bank_holidays = ["2018-07-03"]
BankingDay.banking_day_offset(start_date, offset, bank_holidays)

start_date = "2018-06-28"
offset = 3
bank_holidays = []
BankingDay.banking_day_offset(start_date, offset, bank_holidays)

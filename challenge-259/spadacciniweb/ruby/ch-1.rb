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

require 'date'

def banking_day_offset(start_date, offset, bank_holidays)
    dt = Date.strptime(start_date, '%Y-%m-%d')

    (1..offset).each do |i|
        dt += 1
        while no_banking_day(dt, bank_holidays) == true
            dt += 1
        end
    end

    printf "(start %s offset %s Bank holidays [%s]) -> %s\n",
        start_date,
        offset,
        bank_holidays.join(" / "),
        dt.strftime('%Y-%m-%d');
end

def no_banking_day(dt, bank_holidays)
    if dt.strftime("%u").to_i >= 6 or bank_holidays.include?( dt.strftime('%Y-%m-%d') )
        return true
    end
    false
end

start_date = '2018-06-28'
offset = 3
bank_holidays = ['2018-07-03']
banking_day_offset(start_date, offset, bank_holidays)

start_date = '2018-06-28';
offset = 3;
bank_holidays = [];
banking_day_offset(start_date, offset, bank_holidays);

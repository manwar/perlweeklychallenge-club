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

from dateutil.parser import *
import datetime

def banking_day_offset(start_date, offset, bank_holidays):
    dt = parse(start_date, dayfirst = False, yearfirst = True)

    for i in range(1,5):
        dt += datetime.timedelta(days=1)
        while no_banking_day(dt):
            dt += datetime.timedelta(days=1)

    print("(start %s offset %s Bank holidays [%s]) -> %s" %
            (start_date, offset,
             ' / '.join(bank_holidays),
             dt.strftime('%Y-%m-%d')
            )
    )

def no_banking_day(dt):
    if (dt.weekday() >= 6) or (dt.strftime('%Y-%m-%d') in bank_holidays):
        return 1
    return 0

if __name__ == "__main__":
    start_date = '2018-06-28'
    offset = 3
    bank_holidays = ['2018-07-03']
    banking_day_offset(start_date, offset, bank_holidays)

    start_date = '2018-06-28';
    offset = 3;
    bank_holidays = [];
    banking_day_offset(start_date, offset, bank_holidays)

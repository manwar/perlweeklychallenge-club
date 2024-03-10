//# https://theweeklychallenge.org/blog/perl-weekly-challenge-259/
/*#

Task 1: Banking Day Offset

Submitted by: [42]Lee Johnson
     __________________________________________________________________

   You are given a start date and offset counter. Optionally you also get
   bank holiday date list.

   Given a number (of days) and a start date, return the number (of days)
   adjusted to take into account non-banking days. In other words: convert
   a banking day offset to a calendar day offset.

   Non-banking days are:
a) Weekends
b) Bank holidays

Example 1

Input: $start_date = '2018-06-28', $offset = 3, $bank_holidays = ['2018-07-03']
Output: '2018-07-04'

Thursday bumped to Wednesday (3 day offset, with Monday a bank holiday)

Example 2

Input: $start_date = '2018-06-28', $offset = 3
Output: '2018-07-03'

Task 2: Line Parser
#*/
//# solution by pokgopun@gmail.com

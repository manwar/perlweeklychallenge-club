#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-259/#TASK1
#
# Task 1: Banking Day Offset
# ==========================
#
# You are given a start date and offset counter. Optionally you also get bank
# holiday date list.
#
# Given a number (of days) and a start date, return the number (of days)
# adjusted to take into account non-banking days. In other words: convert a
# banking day offset to a calendar day offset.
#
# Non-banking days are:
#
# a) Weekends
# b) Bank holidays
#
## Example 1
##
## Input: $start_date = '2018-06-28', $offset = 3, $bank_holidays = ['2018-07-03']
## Output: '2018-07-04'
##
## Thursday bumped to Wednesday (3 day offset, with Monday a bank holiday)
#
## Example 2
##
## Input: $start_date = '2018-06-28', $offset = 3
## Output: '2018-07-03'
#
############################################################
##
## discussion
##
############################################################
#
# As long as offset is > 0, we add one to the current date. If the
# new date is neither a bank holiday nor on a weekend, we decrease
# the remaining offset by one.
# I use Date::Calc to take care of the date calculation part.

use strict;
use warnings;
use Date::Calc qw(Day_of_Week Add_Delta_Days);

banking_day_offset('2018-06-28', 3, ['2018-07-03']);
banking_day_offset('2018-06-28', 3);

sub banking_day_offset {
   my ($start_date, $offset, $bank_holidays) = @_;
   $bank_holidays //= [];
   print "Input: start_date = $start_date, offset = $offset, bank_holidays = [" . join(", ", @$bank_holidays) . "]\n";
   while($offset > 0) {
      my $next_date = next_day($start_date);
      if( is_bankholiday_or_weekend($next_date, $bank_holidays) ) {
         $start_date = $next_date;
         next;
      }
      $offset--;
      $start_date = $next_date;
   }
   print "Output: $start_date\n";
}

sub is_bankholiday_or_weekend {
   my ($date, $bank_holidays) = @_;
   return 1 if Day_of_Week(split(/-/, $date)) > 5;
   foreach my $d (@$bank_holidays) {
      return 1 if $d eq $date;
   }
   return 0;
}

sub next_day {
   my $date = shift;
   my ($year, $month, $day) = split /-/, $date;
   my @new_date = Add_Delta_Days($year, $month, $day, 1);
   my $d = sprintf("%04d-%02d-%02d", @new_date);
   return $d;
}

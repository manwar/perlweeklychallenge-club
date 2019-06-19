#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-013/
# Challenge #1
# Write a script to print the date of last Friday of every month of a given year.
# For example, if the given year is 2019 then it should print the following:
# 2019/01/25
# 2019/02/22
# 2019/03/29
# 2019/04/26
# 2019/05/31
# 2019/06/28
# 2019/07/26
# 2019/08/30
# 2019/09/27
# 2019/10/25
# 2019/11/29
# 2019/12/27

use strict;
use warnings;

use DateTime;

my $y = $ARGV[0] || 2019;

for my $m ( 1 .. 12 ) {
   my $d = DateTime->last_day_of_month( year => $y, month => $m );

   my $days_diff = $d->dow - 5; #5 is Friday as day of week
   $days_diff += 7 if ($days_diff < 0);

   $d->subtract(days => $days_diff);

   print $d->ymd('/').$/;
}

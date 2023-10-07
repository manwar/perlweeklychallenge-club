#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
use Time::Local 'timegm_modern';

say seize_the_day(@ARGV);

sub seize_the_day ($year, $month, $weekday_in_month, $weekday) {
   my $date = timegm_modern(0, 0, 12, 1, $month - 1, $year);
   my $date_day_of_week = (gmtime($date))[6];

   # how many days should we advance to find the first occurrence of the
   # target $weekday?
   my $delta = ($weekday + 7 - $date_day_of_week) % 7;

   # advance that many days to land on the first, then additional weeks
   # to land on the target $weekday_in_month.
   $date += ($delta + ($weekday_in_month - 1) * 7) * 24 * 3600;

   # get back the year and month of the date we landed on
   my (undef, undef, undef, $day, $newm, $newy) = gmtime($date);
   $newm += 1; # apply offset for month
   $newy += 1900; # apply offset for year

   # return making sure we're in the same year & month
   return $year == $newy && $month == $newm ? $day : 0;
}

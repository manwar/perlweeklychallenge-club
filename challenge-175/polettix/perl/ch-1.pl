#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

use DateTime;

my $year = shift // 2022;
say for sundays_in($year);

sub sundays_in ($year) {
   my $year_start = DateTime->new(
      year => $year,
      month => 1,
      day  => 1,
      hour => 12,
      time_zone => 'floating',
   );

   # find the first sunday in the year
   my $cursor = $year_start->clone;
   $cursor->add(days => 1) while $cursor->day_of_week % 7;

   # find all last sundays in the year
   my @retval;
   while ($cursor->year == $year) {

      # we will compare a candidate sunday against the next one
      my $candidate = $cursor->clone;
      $cursor->add(days => 7);

      # a jump in the month for the "next" sunday means that our
      # $candidate was the last one in its month, so take it
      push @retval, $candidate->ymd('-')
         if $cursor->month != $candidate->month;
   }
   return @retval;
}

#!/usr/bin/env raku
use v6;
sub MAIN (Int:D $year = 2022) { .put for sundays-in($year) }

sub sundays-in (Int:D $year) {
   my $year-start = Date.new(:$year);

   # find the first sunday in the year
   my $cursor = $year-start;
   $cursor++ while $cursor.day-of-week % 7;

   # find all last sundays in the year
   return gather loop {

      # we will compare a candidate sunday against the next one
      my $candidate = $cursor;
      $cursor += 7;

      # a jump in the month for the "next" sunday means that our
      # $candidate was the last one in its month, so take it
      take $candidate if $cursor.month != $candidate.month;

      # a jump in the year means we've taken the last one in the
      # requested year, so we can just say goodbye
      last if $cursor.year > $candidate.year;
   };
}

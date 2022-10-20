#!/bin/perl

=pod

The Weekly Challenge - 187
 - https://theweeklychallenge.org/blog/perl-weekly-challenge-187/#TASK1

Author: Niels 'PerlBoy' van Dijke

Task 1: Days Together
Submitted by: Mohammad S Anwar

Two friends, Foo and Bar gone on holidays seperately to the same city. 
You are given their schedule i.e. start date and end date.

To keep the task simple, the date is in the form DD-MM and all dates belong 
to the same calendar year i.e. between 01-01 and 31-12. Also the year is 
non-leap year and both dates are inclusive.

Write a script to find out for the given schedule, how many days they spent 
together in the city, if at all.

=cut

use v5.16;
use warnings;

use Date::Simple qw(ymd);
use Date::Range;

use Test::More;

sub daysTogether ($$$$) {
  # Use 2022 as this not a leap year
  my @d = map { ymd(2022, reverse split /-/, $_) } @_;
  my @r = map { Date::Range->new(shift @d,shift @d) } (1,2);

  if ($r[0]->overlaps($r[1])) {
    return $r[0]->overlap($r[1])->length;
  } else {
    return 0;
  }
}

is(daysTogether('12-01','20-01','15-01','18-01'),4);
is(daysTogether('02-03','12-03','13-03','14-03'),0);
is(daysTogether('02-03','12-03','11-03','15-03'),2);
is(daysTogether('30-03','05-04','28-03','02-04'),4);

done_testing;

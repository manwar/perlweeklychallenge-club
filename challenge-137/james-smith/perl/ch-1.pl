#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my $start_day = 1; ## Jan 1st 1900 was a Monday.

foreach my $year ( 1900 .. 2100 ) {
  my $is_leap_year = ! $year % 4 && ( $year % 100 || ! $year % 400 );
  say $year if $start_day == 4 || $start_day == 3 && $is_leap_year;
  $start_day = ( $start_day + 1 + $is_leap_year ) % 7;
}

## Compute if leap year?
## Long year if starts on Thursday (day 4) or Wednesday (day 3) in a leap year
## Next year starts on the next day of the week Mon->Tues ....
##   except in a leap year when it moves 2 Mon->Wed

#!/usr/local/bin/perl

use strict;
use warnings;
use feature qw(say state);
use DateTime;

my @L = (31,31,28,31,30,31,30,31,31,30,31,30,31);

## Note this calculation is based on the Gregorian calendar rather than the Julian one.
## The year part of the calculation can be adjusted to take into Julian dates. There
## are issues on what to use as the cut-off, the date of adpoption of the Gregorian
## calendar ranges from 1582 to 2016. The UK didn't adopt the calendar into 1754,
## where in large parts of Europe is was adopted from 1582.

foreach my $yr ( @ARGV ) {
  say join ' ', last_day_of_months( $yr );
}

sub last_day_of_months {
  my $yr = shift;
                        ## Compute if leap year - set the length of feb accordingly.
  $L[2] = (my $ly  = !( $yr%400 && ( ($yr%4) || !($yr%100) ) )) ? 29 : 28;
                        ## Compute the last Sunday in december of the previous year
  my $last = 31 - ( int(($yr%100)/4) - $ly + 2 * (int(3 - $yr/100)%4) + $yr%100 ) % 7;
                        ## Finally work out the last days of the following 2 months.
  map { ( ($last += 35 - $L[$_-1]) > $L[$_] ) && ($last-=7);
        sprintf '%04d-%02d-%02d', $yr, $_, $last
      } 1..12;
}


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

say "LONG";
foreach ( @ARGV ) {
  say "  @{[last_day_of_months($_)]}";
}
say "COMPACT";
foreach ( @ARGV ) {
  say "  @{[last_day_of_months($_)]}";
}
say '';

sub last_day_of_months {
  my $yr = shift;
                        ## Compute if leap year - set the length of feb accordingly.
  $L[2] = (my $ly  = !($yr%400) ^ !($yr%100) ^ !($yr%4) ) ? 29 : 28;
                        ## Compute the last Sunday in december of the previous year
  my $last = 31 - ( int($yr%100/4) - $ly + 6 - 2*$yr/100%4 + $yr%100 ) % 7;
                        ## Finally work out the last days of the following 2 months.
  map { ( ($last += 35 - $L[$_-1]) > $L[$_] ) && ($last-=7);
        sprintf '%04d-%02d-%02d', $yr, $_, $last
      } 1..12
}

#123456789#123456789#123456789#123456789#123456789#123456789#123456789#123456789
sub l {
  my$y=pop;
  $L[2]=(my$f=!($y%400)^!($y%100)^!($y%4))?29:28;
  my$l=31-(int($y%100/4)-$f+6-2*$y/100%4+$y%100)%7;
  map{(($l+=35-$L[$_-1])>$L[$_])&&($l-=7);sprintf'%04d-%02d-%02d',$y,$_,$l}1..12
}


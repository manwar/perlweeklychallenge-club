#!perl.exe

use strict;
use warnings;
use ntheory qw/divisors /;
use feature qw/say/;

# AUTHOR: Robert DiCicco
# DATE: 2022-06-28
# Challenge 171 Abundant Number ( Perl )


my $n = 1;                                # Starting Number
my $count = 0;

while ($count < 20) {                     # Looking for 20 odd numbers

  my $sum = 0;                            # Hold our sum of divisors
  my @arr = divisors($n);
  pop(@arr);

  foreach(@arr) {                          # Add each divisor to the sum
    my $val = $_;
    $sum += $val;
  }

  if (($sum > $n) && ($n % 2 == 1)) {     # if the sum of divisors is greater than the source number,
    print "$n ";                          # and it is odd, print it
    $count++;
  }

  $n++;                                   # get next number
}

print "\n";

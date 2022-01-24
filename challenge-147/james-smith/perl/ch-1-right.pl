#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Time::HiRes qw(time);

my ( $TEMPLATE, $idx, $t0, $c, @primes) =
   ( "%6d\t%28d\t%15.6f\n", 0, time, 5, 3 );
my @tprimes_current = (2,3,5,7);
printf $TEMPLATE, ++$idx, $_, time - $t0 foreach @tprimes_current;

for my $p ( 1 .. 100 ) {
  @tprimes_current||last;
  my @tprimes_new = ();
  foreach my $base ( @tprimes_current ) {
    B: foreach my $last ( 1,3,7,9 ) {
      my $n = $base.$last; ## Is this prime?
      foreach( ;$primes[-1]*$primes[-1]<$n;$c+=2) {
        ($_*$_>$c)?(push(@primes,$c),last):$c%$_||last for @primes;
      }
      ## check if $n is composite;
      $n%$_||next B foreach @primes;
      push @tprimes_new, $n;
      printf $TEMPLATE, ++$idx, $n, time - $t0;
    }
  }
  @tprimes_current = @tprimes_new;
}


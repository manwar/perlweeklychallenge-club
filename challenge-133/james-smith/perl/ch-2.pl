#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);

my(@sum_pf,@primes); ## Caches of digit sums of factors of $N

say $_ foreach smith_numbers(@ARGV?$ARGV[0]:100);

sub sum_digits { my $t = 0; $t+=$_ foreach split //, $_[0]; $t } ## Digit sum of number...

sub sum_prime_factors {
  ## We don't need to remember factors - just the digit sum...
  my $N = shift;

  ## If we are composite then store the sum of the digit factors for the composite and return...
  ( $N % $_) ? (( $N<$_*$_) && last ) : ( return $sum_pf[$N] = $sum_pf[$N/$_] + $sum_pf[$_] )
    foreach @primes;

  ## Otherwise we are prime so add to primes and return nothing....
  $sum_pf[$N] = sum_digits $N;
  push @primes, $N;
  return 0; ## Although we now the sum digits we return 0 as prime!
}

sub smith_numbers { ## This is the short form! using &&
  my ( $count, $n, @sn ) = (shift,1);
  $sum_pf[ $count * 40 ] = 0; ## Pre-size array
  ( sum_digits( $n ) == sum_prime_factors $n ) &&     ## Diff between sums of factors == 0
  ( push @sn, $n                             ) &&     ## push
  ( @sn == $count                            ) &&     ## check length & return...
  ( return @sn                               ) while $n++;
}

## Same functions without comments....

sub cl_sum_digits { my $t = 0; $t+=$_ foreach split //, $_[0]; $t }

sub cl_sum_prime_factors {
  my $N = shift;
  ( $N % $_) || ( return $sum_pf[$N] = $sum_pf[$N/$_] + $sum_pf[$_] ) foreach @primes;
  $sum_pf[$N] = cl_sum_digits $N;
  push @primes, $N;
  return 0;
}

sub cl_smith_numbers {
  my ( $count, $n, @sn ) = (shift,1);
  $sum_pf[ $count * 40 ] = 0;
  ( cl_sum_digits( $n ) == cl_sum_prime_factors $n ) &&
  ( push @sn, $n                                   ) &&
  ( @sn == $count                                  ) &&
  ( return @sn                                     ) while $n++;
}



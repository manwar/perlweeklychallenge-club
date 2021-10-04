#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);

my(@primes,%ds,%comp) = (2,3);
say $_ foreach smith_numbers(@ARGV?$ARGV[0]:100);
#say $_ foreach smith_numbers_readable(@ARGV?$ARGV[0]:100);

sub sum {        my $t = 0; $t+=$_ foreach @_; $t; }
sub sum_digits { return $ds{$_[0]} ||= sum split //, $_[0]; }

sub prime_factors {
  my $N = shift;

  ## If we are composite then store the factors for the composite and return...
  ( $N % $_) or ( return @{ $comp{$N} = [ $_, @{$comp{ $N / $_ }||[$N/$_]}] } ) foreach @primes;

  ## Otherwise we are prime so add to primes and return nothing....
  push @primes, $N;
  return;
}

sub smith_numbers_readable {
  my ( $C, $n, @sn ) = (shift,3);
  while($n++) { ## $n starts at 4 ... lowest possible smith number is 4 ( composite or 2 x 2 )
    next unless my @q = prime_factors($n); ## Must be composite as prime_factors returns list...
    next if sum_digits($n) - sum map { sum_digits $_ } @q; ## Digit sums are equal...
    push @sn, $n;
    return @sn if @sn==$C;
  }
}


sub smith_numbers { ## This is the short form! using &&
  my ( $C, $n, @sn ) = (shift,3);
  ( sum_digits( $n ) - sum map { sum_digits $_ } prime_factors( $n ) ) ||
  ( push @sn, $n                                                     ) &&
  ( @sn == $C                                                        ) &&
  ( return @sn                                                       ) while $n++;
}



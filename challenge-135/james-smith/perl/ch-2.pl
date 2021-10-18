#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ '2936921', 1 ],
  [ '1234567', 0 ],
  [ 'B0YBKL9', 1 ],
  [ '0263494', 1 ],
  [ '0540528', 1 ],
  [ 'BG03Y86', 1 ],
);

is( is_sedol($_->[0]), $_->[1] ) foreach @TESTS;

done_testing();

sub is_sedol {
## Check correct format...
  return 0 unless $_[0] =~ m{^[0-9B-HJ-NP-TW-Z]{6}\d$};

## Total and weights foreach digit
  my( $t, @wts ) = qw(0 1 3 1 7 3 9 1);

## Calculate SEDOL sum... note YODA sum -55 + ord $_ to avoid precedence issue
  $t += shift @wts * ( $_ =~/[A-Z]/ ? -55 + ord $_ : $_ ) foreach split m//, $_[0];

## Return true if total modulo 10 is 0
  return $t % 10 ? 0 : 1;
}


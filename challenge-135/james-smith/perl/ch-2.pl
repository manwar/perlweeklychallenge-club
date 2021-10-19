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
  [ '1A34O67', 0 ],
  [ 'BG03Y86', 1 ],
);

is( is_sedol(        $_->[0]), $_->[1] ) for @TESTS;
is( is_sedol_compact($_->[0]), $_->[1] ) for @TESTS;

done_testing();

sub is_sedol {
## Check correct format... numbers and consonants only
  return 0 unless $_[0] =~ m{^[0-9B-HJ-NP-TW-Z]{6}\d$};

## Accumulator and weights for each charachter
  my( $t, @w ) = qw(0 1 3 1 7 3 9 1);

## Calculate SEDOL sum... note YODA sum -55 + ord $_ to avoid precedence issue
  $t += ( /\d/ ? $_ : -55 + ord $_ ) * shift @w for split //, $_[0];

## Return true (1) if total modulo 10 is 0, and false (0) otherwise
  return $t % 10 ? 0 : 1;
}

sub is_sedol_compact {
  return 0if$_[0]!~/^[0-9B-HJ-NP-TW-Z]{6}\d$/;
  my($t,@w)=qw(0 1 9 3 7 1 3 1);
  $t+=(/\d/?$_:-55+ord$_)*pop@w for split//,$_[0];
  $t%10?0:1
}


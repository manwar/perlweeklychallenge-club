#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ [3,3], 6 ],
  [ [3,5], 11 ],
);

is( distinct_terms(@{$_->[0]}), $_->[1] ) foreach @TESTS;

done_testing();

sub distinct_terms {
  my($m,$n,%x) = @_;
  for my $i (1..$m) {
    $x{$i*$_}++ for 1..$n;
  }
  return scalar keys %x;
}


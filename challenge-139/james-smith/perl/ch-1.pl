#!/usr/local/bin/perl

use strict;
use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ [1..5], 1 ],
  [ [1,3,2,4,5], 0 ],
);

is( in_order(@{$_->[0]}), $_->[1] ) foreach @TESTS;

done_testing();

sub in_order {
  my $p = shift;
  ($p>$_) ? (return 0) : ($p=$_) foreach @_;
  return 1;
}


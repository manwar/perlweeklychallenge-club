#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

my @TESTS = (
  [ 10, 3 ],
  [ 27, 5 ],
  [ 85, 9 ],
  [ 101, 10 ],
  [ 418529770, 20458 ],
);

is( find_root($_->[0]), $_->[1] ) foreach @TESTS;

done_testing();

sub find_root {
  my($x,$y) = (my $n = shift)>>1;
  return $n unless $x;
  $x = $y while ($y = ($x+$n/$x)>>1) < $x;
  return $x;
}


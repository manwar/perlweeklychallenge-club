#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ 15, 8 ],
  [ 25, 13 ],
  [ 100, 80 ],
  [ 1000, 728 ],
  [ 1100, 728 ],
  [ 1200, 728 ],
  [ 1300, 728 ],
  [ 2000, 729 ],
  [ 2100, 809 ],
  [ 2200, 810 ],
  [ 3000, 1458 ],
  [ 4000, 2187 ],
  [ 5000, 2916 ],
  [ 10000, 6560 ],
  [ 100000, 59048 ],
  [ 1000000, 531440  ],
);

is( get_no_one_count($_->[0]), $_->[1] ) foreach @TESTS;
done_testing();

sub get_no_one_count {
  my $n = shift;
  return scalar grep { ! m{1} } 2..$n;
}


#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Const::Fast qw(const);

const my @M => (
  [0,3,1,7,5,9,8,6,4,2],
  [7,0,9,2,1,5,4,8,6,3],
  [4,2,0,6,8,7,1,3,5,9],
  [1,7,5,0,9,8,3,4,2,6],
  [6,1,2,3,0,4,5,9,7,8],
  [3,6,7,4,2,0,9,5,8,1],
  [5,8,6,9,7,2,0,1,3,4],
  [8,9,4,5,3,6,2,0,1,7],
  [9,4,3,8,6,1,7,2,0,5],
  [2,5,8,1,4,3,6,7,9,0],
);

my @TESTS_1 = ( [ 5724, 1 ], [ 5727, 0 ] );
my @TESTS_2 = ( [ 572,  4 ], [ '000000000000000000000000000000572', 4 ] );

is( check_damm($_->[0]), $_->[1] ) foreach @TESTS_1;
is( damm_digit($_->[0]), $_->[1] ) foreach @TESTS_2;

done_testing();

sub check_damm {
  my $i = 0;
  $i = $M[$i][$_] for split //,pop;
  $i?0:1;
}

sub damm_digit {
  my $i = 0;
  $i = $M[$i][$_] for split //,pop;
  $i;
}


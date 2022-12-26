#!/usr/local/bin/perl

use strict;
use warnings;
use feature qw(say);
use Test::More;

my @TESTS = (
  [ [1,0,3,0,0,5], '1 3 5 0 0 0' ],
  [ [1,6,4],       '1 6 4'       ],
  [ [0,1,0,2,0],   '1 2 0 0 0'   ],
  [ [(0,1) x 100 ], "@{[ (1)x 100, (0)x 100 ]}" ],
);

is( "@{[ move_zero(@{$_->[0]}) ]}", $_->[1] ) for @TESTS;

sub move_zero{grep({$_}@_),grep{!$_}@_}

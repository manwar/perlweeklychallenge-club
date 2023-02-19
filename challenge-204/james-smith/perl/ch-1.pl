#!/usr/local/bin/perl

use strict;
use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use List::Util qw(sum0);

my @TESTS = (
  [ [ 1,2,2,3       ], 1 ],
  [ [ 1,3,2         ], 0 ],
  [ [ 6,5,5,4       ], 1 ],
  [ [ 1,1,1,1,1,1,1 ], 1 ],
  [ [ 1,1,1,1,2,2,2 ], 1 ],
  [ [ 1,1,1,1,2,1,1 ], 0 ],
  [ [ 1,1,1,1,0,0,0 ], 1 ],
  [ [ 1,1,1,1,0,1,1 ], 0 ],
);

is( monotonic( @{$_->[0]} ), $_->[1] ) for @TESTS;

done_testing();

sub monotonic {
  my($n,$d,$t)=$_[0];
  ($t=$n<=>$_) && ($d||=$t) != $t ? (return 0) : ($n=$_) for @_;
  1;
}

#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ 3, [1,4,2,3,5], "4 5" ],
  [ 4, [9,0,6,2,3,8,5], "9 6 8 5" ],
);

is( "@{[ filter($_->[0],$_->[1]) ]}", $_->[2] ) foreach @TESTS;

done_testing();

sub filter {
  grep { $_ > $_[0] } @{$_[1]};
}


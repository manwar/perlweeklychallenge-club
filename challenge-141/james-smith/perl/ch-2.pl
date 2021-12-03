#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (
  [ [1234,2], 9 ],
  [ [ 768,4], 3 ],
);

is( like_numbers(@{$_->[0]}), $_->[1] ) foreach @TESTS;

done_testing();

sub like_numbers {
  scalar grep { !($_%$_[1]) } get_nums( $_[0] );
}

sub get_nums {
  my @nums = split //, my $m = shift;
  return map { my $n=$_<<1; join '',grep{($n>>=1)&1} @nums } 1..(1<<@nums)-2;
}


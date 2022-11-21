#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = ( [ [1,0,5], 4 ], [ [0,2,0],-1], [ [0,3,0], 2 ] );

is( equal_dis(  @{$_->[0]} ), $_->[1] ) for @TESTS;
done_testing();

sub equal_dis {
  my($av,$k) = (0,0);
  $av+=$_ for @_;
  return -1 if $av%@_;
  $av/=@_;
  $k+=abs($av-$_[0]),$_[1]-=$av-shift while @_>1;
  $k;
}

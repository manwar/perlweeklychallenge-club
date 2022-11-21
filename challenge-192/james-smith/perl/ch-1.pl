#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

my @TESTS = (  [5,2],[4,3],[6,1] );

is( binary_flip( $_->[0] ), $_->[1] ) for @TESTS;
done_testing();

sub binary_flip {
  my($r,$k,$n) = (0,1,shift);
  $r=(1-$n&1)*$k+$r,$k<<=1,$n>>=1 while $n;
  $r;
}

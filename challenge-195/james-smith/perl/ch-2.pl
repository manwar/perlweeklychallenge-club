#!/usr/local/bin/perl

use strict;
use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);

my @TESTS = (
  [ [ 1,1,2,6,2 ] =>  2 ],
  [ [ 1,3,5,7   ] => -1 ],
  [ [ 6,4,4,6,1 ] =>  4 ],
);

is( mf_even( @{$_->[0]} ), $_->[1] ) for @TESTS;
done_testing();

sub mf_even {
  my($m,$v,%f)=(-1,-1);
  $_%2 || $f{$_}++ for @_; ## Compute frequencies
  ( $f{$_}>$v || $f{$_}==$v && $_<$m ) && ( $m=$_,$v=$f{$_} ) for keys %f;
  $m
}

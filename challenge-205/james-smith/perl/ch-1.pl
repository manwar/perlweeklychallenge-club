#!/usr/local/bin/perl

use strict;
use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);

my @TESTS = (
  [ [5,3,4],   3, 3 ],
  [ [5,6],     6, 6 ],
  [ [5,4,4,3], 3, 4 ],
);

is( third(        @{$_->[0]} ), $_->[2] ) for @TESTS;
is( third_unique( @{$_->[0]} ), $_->[1] ) for @TESTS;

done_testing();

sub third {
  my ($i,$j,$k) = sort { $b <=> $a } splice @_,0,3;
  return $i unless defined $k;
    $_ > $i ? (($i,$j,$k)=($_,$i,$j))
  : $_ > $j ? (($j,$k)=($_,$j))
  : ( $_ > $k ) && ($k=$_) for @_;
  $k;
}

sub third_unique {
  my ($i,$j,$k) = shift;
    $_ > $i  ? (($i,$j,$k)=($_,$i,$j))
  : $_ == $i ? ()
  : !defined $j || $_ > $j  ? (($j,$k)=($_,$j))
  : defined $j && $_ == $j ? ()
  : ( !defined $k || $_ > $k ) && ($k=$_) for @_;
  $k//$i;
}

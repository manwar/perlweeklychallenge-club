#!/usr/local/bin/perl

use strict;
use warnings;
use feature qw(say);
use Test::More;

my @TESTS = (
  [ [1,1,2],       1 ],
  [ [2,1,2],       0 ],
  [ [1,1,1,2],     0 ],
  [ [1,2,1,3,1,5], 1 ],
  [ [1,2,1,3,1],   1 ],
  [ [1,2],         1 ],
  [ [2,1],         1 ],
  [ [1],           1 ],
  [ [1,5,1,1,6,4], 1 ],
  [ [1,3,2,2,3,1], 1 ],
  [ [2,3,1,3,1,2,1], 1 ],
);


is( check( wiggle_sort(@{$_->[0]}) ), $_->[1] ) for @TESTS;
done_testing();

sub wiggle_sort {
  return @_ if @_<2;
  @_ = sort { $a <=> $b } @_;
  my @q = splice @_,(@_+1)/2;
  return if @q < @_ && $_[1]==$q[0];
  return map { @q ? ( $_ == $q[0] ? (return) : $_,shift @q ) : $_ } @_;
}

sub check {
  return 0 unless @_;
  my($t,$d) = (shift,1);
  ($_<=>$t)!=$d?return 0:($t=$_,$d*=-1) for @_;
  return 1;
}


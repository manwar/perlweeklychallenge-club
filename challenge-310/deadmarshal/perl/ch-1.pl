#!/usr/bin/env perl
use strict;
use warnings;
use Data::Show;
use Set::Scalar;

sub arrays_intersection{
  my ($arr) = @_;
  return () unless @$arr;
  my $s = Set::Scalar->new($arr->[0]->@*);
  map{$s *= Set::Scalar->new(@$_)} @{$arr}[1..$#$arr];
  $s->elements
}

print show arrays_intersection([[1,2,3,4],[4,5,6,1],[4,2,1,3]]);
print show arrays_intersection([[1,0,2,3],[2,4,5]]);
print show arrays_intersection([[1,2,3],[4,5],[6]]);


#!/usr/bin/env perl
use strict;
use warnings;
use Data::Show;

sub twod_array{
  my ($arr,$r,$c) = @_;
  map{[splice @$arr,0,$c]} 1..$r
}

print show twod_array([1,2,3,4],2,2);
print show twod_array([1,2,3],1,3);
print show twod_array([1,2,3,4],4,1);


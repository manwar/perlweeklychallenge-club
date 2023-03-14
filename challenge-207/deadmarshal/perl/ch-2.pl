#!/usr/bin/env perl
use strict;
use warnings;

sub h_index{
  my ($arr) = @_;
  map {return $_ if $_ >= $arr->[$_]} 0..$#$arr;
}

printf "%d\n", h_index([10,8,5,4,3]);
printf "%d\n", h_index([25,8,5,3,3]);


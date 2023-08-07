#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(min);

sub empty_array{
  my ($count,$arr) = (0,@_);
  while(@$arr){
    $arr->[0] == min(@$arr) ? shift @$arr : push @$arr,shift @$arr;
    $count++
  }
  $count
}

printf "%d\n", empty_array([3,4,2]);
printf "%d\n", empty_array([1,2,3]);


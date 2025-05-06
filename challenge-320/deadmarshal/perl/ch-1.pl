#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(max);

sub maximum_count{
  my ($n,$p) = (0,0);
  map{if($_ != 0) {$_ < 0 ? $n++ : $p++}} @{$_[0]};
  max($n,$p)
}

printf "%d\n",maximum_count([-3,-2,-1,1,2,3]);
printf "%d\n",maximum_count([-2,-1,0,0,1]);
printf "%d\n",maximum_count([1,2,3,4]);


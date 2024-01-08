#!/usr/bin/env perl
use strict;
use warnings;

sub smallest_index{
  map{return $_ if $_ % 10 == $_[0]->[$_]}0..$#{$_[0]};
  -1
}

printf "%d\n",smallest_index([0,1,2]);
printf "%d\n",smallest_index([4,3,2,1]);
printf "%d\n",smallest_index([1,2,3,4,5,6,7,8,9,0]);


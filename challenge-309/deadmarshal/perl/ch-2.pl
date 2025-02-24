#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(min);

sub min_diff{
  my @sorted = sort{$a<=>$b}@{$_[0]};
  min(map{$sorted[$_] - $sorted[$_-1]}1..$#sorted)
}

printf "%d\n",min_diff([1,5,8,9]);
printf "%d\n",min_diff([9,4,1,7]);


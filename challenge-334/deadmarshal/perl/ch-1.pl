#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(sum0);

sub range_sum{
  sum0 @{$_[0]}[$_[1]..$_[2]];
}

printf "%d\n",range_sum([-2,0,3,-5,2,-1],0,2);
printf "%d\n",range_sum([1,-2,3,-4,5],1,3);
printf "%d\n",range_sum([1,0,2,-1,3],3,4);
printf "%d\n",range_sum([-5,4,-3,2,-1,0],0,3);
printf "%d\n",range_sum([-1,0,2,-3,-2,1],0,2);


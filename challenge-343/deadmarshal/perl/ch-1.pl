#!/usr/bin/env perl
use strict;
use warnings;

sub zero_friend{
  my $zf = abs shift @{$_[0]};
  abs $_ < $zf and $zf = abs for @{$_[0]};
  $zf
}

printf "%d\n",zero_friend([4,2,-1,3,-2]);
printf "%d\n",zero_friend([-5,5,-3,3,-1,1]);
printf "%d\n",zero_friend([7,-3,0,2,-8]);
printf "%d\n",zero_friend([-2,-5,-1,-8]);
printf "%d\n",zero_friend([-2,2,-4,4,-1,1]);


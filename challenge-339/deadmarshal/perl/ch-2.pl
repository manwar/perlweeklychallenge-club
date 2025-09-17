#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(max);

sub peak_point{
  my $s = 0;
  max 0,map {$s += $_} @{$_[0]}
}

printf "%d\n",peak_point([-5,1,5,-9,2]);
printf "%d\n",peak_point([10,10,10,-25]);
printf "%d\n",peak_point([3,-4,2,5,-6,1]);
printf "%d\n",peak_point([-1,-2,-3,-4]);
printf "%d\n",peak_point([-10,15,5]);


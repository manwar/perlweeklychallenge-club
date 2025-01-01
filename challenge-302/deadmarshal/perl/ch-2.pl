#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(min max);

sub step_by_step{
  my $s = 0;
  my $t = $_[0]->[0];
  map{$s += $_; $t = min $t,$s} @{$_[0]};
  max 1,1-$t
}

printf "%d\n",step_by_step([-3,2,-3,4,2]);
printf "%d\n",step_by_step([1,2]);
printf "%d\n",step_by_step([1,-2,-3]);


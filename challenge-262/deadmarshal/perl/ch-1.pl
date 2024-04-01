#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(max);

sub max_positive_negative{
  my ($neg,$pos) = 0 x 2;
  map{$neg++ if $_ < 0;$pos++ if $_ > 0}@{$_[0]};
  max $neg,$pos
}

printf "%d\n",max_positive_negative([-3,1,2,-1,3,-2,4]);
printf "%d\n",max_positive_negative([-1,-2,-3,1]);
printf "%d\n",max_positive_negative([1,2]);


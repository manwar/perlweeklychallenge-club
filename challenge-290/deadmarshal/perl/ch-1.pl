#!/usr/bin/env perl
use strict;
use warnings;

sub double_exist{
  my %h;
  $h{$_}++ foreach @{$_[0]};
  map{return 1 if exists $h{$_ * 2}} keys %h;
  0
}

printf "%d\n",double_exist([6,2,3,3]);
printf "%d\n",double_exist([3,1,4,13]);
printf "%d\n",double_exist([2,1,4,2]);


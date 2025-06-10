#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(max);

sub consecutive_one{
  max 0,map length,split /[^1]+/,join '',@{$_[0]}
}

printf "%d\n",consecutive_one([0,1,1,0,1,1,1]);
printf "%d\n",consecutive_one([0,0,0,0]);
printf "%d\n",consecutive_one([1,0,1,0,1,1]);


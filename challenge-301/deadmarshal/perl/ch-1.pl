#!/usr/bin/env perl
use strict;
use warnings;

sub largest_number{
  join '',sort {$b.$a <=> $a.$b} @{$_[0]}
}

printf "%s\n",largest_number([20,3]);
printf "%s\n",largest_number([3,30,34,5,9]);


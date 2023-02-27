#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(uniq);

sub third_highest{
  my @sorted = sort {$b <=> $a} uniq @{$_[0]};
  $sorted[2] // $sorted[0];
}

printf "%d\n", third_highest([5,3,4]);
printf "%d\n", third_highest([5,6]);
printf "%d\n", third_highest([5,4,4,3]);


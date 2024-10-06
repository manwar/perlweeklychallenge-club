#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(max);
use List::MoreUtils qw(uniq);

sub third_maximum{
  my @arr = sort{$b <=> $a} uniq @{$_[0]};
  $arr[2] // $arr[0]
}

printf "%d\n",third_maximum([5,6,4,1]);
printf "%d\n",third_maximum([4,5]);
printf "%d\n",third_maximum([1,2,2,3]);


#!/usr/bin/env perl
use strict;
use warnings;
use List::MoreUtils qw(singleton);

sub unique_number{
  my @arr = singleton @{$_[0]};
  @arr == 1 ? $arr[0] : undef
}

printf "%d\n",unique_number([3,3,1]);
printf "%d\n",unique_number([3,2,4,2,4]);
printf "%d\n",unique_number([1]);
printf "%d\n",unique_number([4,3,1,1,1,4]);


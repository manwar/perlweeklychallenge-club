#!/usr/bin/env perl
use strict;
use warnings;
use ntheory qw(hammingweight);
use List::Util qw(sum0);

sub sum_of_values{
  sum0 map{hammingweight$_==$_[1]?$_[0]->[$_]:()}0..$#{$_[0]}
}

printf "%d\n",sum_of_values([2,5,9,11,3],1);
printf "%d\n",sum_of_values([2,5,9,11,3],2);
printf "%d\n",sum_of_values([2,5,9,11,3],0);


#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(sum0);

sub sum_diffrence{
  abs(sum0(@{$_[0]}) - sum0(split '',join '',@{$_[0]}))
}

printf "%d\n",sum_diffrence([1,23,4,5]);
printf "%d\n",sum_diffrence([1,2,3,4,5]);
printf "%d\n",sum_diffrence([1,2,34]);


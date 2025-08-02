#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(sum0);

sub element_digit_sum{
  abs(sum0(map{split ''}@{$_[0]}) - sum0(@{$_[0]}))
}

printf "%d\n",element_digit_sum([1,2,3,45]);
printf "%d\n",element_digit_sum([1,12,3]);
printf "%d\n",element_digit_sum([1,2,3,4]);
printf "%d\n",element_digit_sum([236,416,336,350]);


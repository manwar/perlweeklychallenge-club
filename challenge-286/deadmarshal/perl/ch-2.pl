#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(min max);

sub order_game{
  my ($arr) = @_;
  while(@$arr > 2){
    my @t;
    foreach my($a,$b,$c,$d)(@$arr){
      push @t,min($a,$b),max($c,$d)
    }
    @$arr = @t;
  }
  min @$arr
}

printf "%d\n",order_game([2,1,4,5,6,3,0,2]);
printf "%d\n",order_game([0,5,3,2]);
printf "%d\n",order_game([9,2,1,4,5,6,0,7,3,1,3,5,7,9,0,8]);


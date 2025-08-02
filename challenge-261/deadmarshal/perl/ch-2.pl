#!/usr/bin/env perl
use strict;
use warnings;
use List::MoreUtils qw(firstidx);

sub multiply_by_two{
  my ($arr,$start) = @_;
  $start *= 2 while((firstidx{$start == $_}@$arr)!=-1);
  $start
}

printf "%d\n",multiply_by_two([5,3,6,1,12],3);
printf "%d\n",multiply_by_two([1,2,4,3],1);
printf "%d\n",multiply_by_two([5,6,7],2);


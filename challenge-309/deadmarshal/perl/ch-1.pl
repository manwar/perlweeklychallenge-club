#!/usr/bin/env perl
use strict;
use warnings;
use List::MoreUtils qw(slide);

sub min_gap{
  my ($arr) = @_;
  my $min = $arr->[0];
  my $min_gap = $arr->[1] - $arr->[0];
  foreach my $i(2..$#$arr){
    my $gap = $arr->[$i] - $arr->[$i-1];
    if($gap < $min_gap){
      $min = $arr->[$i];
      $min_gap = $gap
    }
  }
  $min
}

printf "%d\n",min_gap([2,8,10,11,15]);
printf "%d\n",min_gap([1,5,6,7,14]);
printf "%d\n",min_gap([8,20,25,28]);


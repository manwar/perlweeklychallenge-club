#!/usr/bin/env perl
use strict;
use warnings;

sub good_triplets{
  my ($A,$x,$y,$z) = @_;
  my $count = 0;
  for(my $i = 0; $i < @$A; ++$i){
    for(my $j = 0; $j < @$A; ++$j){
      for(my $k = 0; $k < @$A; ++$k){
	if((abs($A->[$i] - $A->[$j]) <= $x) &&
	   (abs($A->[$j] - $A->[$k]) <= $y) &&
	   (abs($A->[$i] - $A->[$k]) <= $z) &&
	   (0 <= $i < $j < $k <= @$A)){$count++}
      }
    }
  }
  $count;
}

printf "%d\n", good_triplets([3,0,1,1,9,7],7,2,3);
printf "%d\n", good_triplets([1,1,2,2,3],0,0,1);


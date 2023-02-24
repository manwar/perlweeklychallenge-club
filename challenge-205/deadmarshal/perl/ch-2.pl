#!/usr/bin/env perl
use strict;
use warnings;

sub maximum_xor{
  my ($A) = @_;
  my $max = 0;
  foreach my $i(0..$#$A){
    foreach my $j(0..$#$A){
      my $temp = $A->[$i] ^ $A->[$j];
      $max = $temp if $max < $temp;
    }
  }
  $max;
}

printf "%d\n", maximum_xor([1,2,3,4,5,6,7]);
printf "%d\n", maximum_xor([2,4,1,3]);
printf "%d\n", maximum_xor([10,5,7,12,8]);


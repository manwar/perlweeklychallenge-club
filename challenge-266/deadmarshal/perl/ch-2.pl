#!/usr/bin/env perl
use strict;
use warnings;

sub x_matrix{
  my ($mat) = @_;
  my $n = @$mat;
  foreach my $i(0..$n-1){
    foreach my $j(0..$n-1){
      if($i == $j || $i+$j == $n-1){
	return 0 if $mat->[$i][$j] == 0
      }
      elsif($mat->[$i][$j] != 0){return 0}
    }
  }
  1
}

printf "%d\n",x_matrix([[1,0,0,2],
			[0,3,4,0],
			[0,5,6,0],
			[7,0,0,1]]);

printf "%d\n",x_matrix([[1,2,3],
			[4,5,6],
			[7,8,9]]);

printf "%d\n",x_matrix([[1,0,2],
			[0,3,0],
			[4,0,5]]);


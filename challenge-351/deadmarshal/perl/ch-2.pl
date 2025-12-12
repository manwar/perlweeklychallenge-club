#!/usr/bin/env perl
use strict;
use warnings;

sub arithmetic_progression{
  my ($arr) = @_;
  @$arr = sort {$a <=> $b} @$arr;
  my $d = abs(shift(@$arr) - shift(@$arr));
  for(my $i = 0; $i < $#$arr-1; ++$i){
    return 0 if abs($arr->[$i] - $arr->[$i+1]) != $d
  }
  1
}

printf "%d\n",arithmetic_progression([1,3,5,7,9]);
printf "%d\n",arithmetic_progression([9,1,7,5,3]);
printf "%d\n",arithmetic_progression([1,2,4,8,16]);
printf "%d\n",arithmetic_progression([5,-1,3,1,-3]);
printf "%d\n",arithmetic_progression([1.5,3,0,4.5,6]);


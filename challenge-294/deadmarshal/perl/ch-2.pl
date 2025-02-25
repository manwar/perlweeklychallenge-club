#!/usr/bin/env perl
use strict;
use warnings;

sub next_permutation{
  my ($arr) = @_;
  my $p = -1;
  for(my $i = $#$arr-1; $i >= 0; --$i){
    do{$p = $i; last}if($arr->[$i] < $arr->[$i+1])
  }
  return reverse @$arr if $p == -1;
  for(my $i = $#$arr; $i >= $p+1; --$i){
    if($arr->[$i] > $arr->[$p]){
      ($arr->[$i],$arr->[$p]) = ($arr->[$p],$arr->[$i]);
      last
    }
  }
  @$arr
}

printf "(%s)\n",join ', ',next_permutation([1,2,3]);
printf "(%s)\n",join ', ',next_permutation([2,1,3]);
printf "(%s)\n",join ', ',next_permutation([3,1,2]);


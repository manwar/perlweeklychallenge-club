#!/usr/bin/env perl
use strict;
use warnings;
use Algorithm::Combinatorics qw(permutations);

sub maximise_greatness{
  my ($max,$arr) = (0,@_);
  my $iter = permutations($arr);
  while(my $c = $iter->next){
    my $count = grep{$arr->[$_] < $c->[$_]} 0..$#$arr;
    $max = $count if $count > $max;
  }
  $max
}

printf "%d\n",maximise_greatness([1,3,5,2,1,3,1]);
printf "%d\n",maximise_greatness([1,2,3,4]);


#!/usr/bin/env perl
use strict;
use warnings;

sub good_pairs{
  my ($arr) = @_;
  my $count = 0;
  for(my $i = 0; $i < @$arr; ++$i){
    for(my $j = $i+1; $j < @$arr; ++$j){
      $count++ if($arr->[$i] == $arr->[$j]);
    }
  }
  $count;
}

printf "%d\n", good_pairs([1,2,3,1,1,3]);
printf "%d\n", good_pairs([1,2,3]);
printf "%d\n", good_pairs([1,1,1,1]);


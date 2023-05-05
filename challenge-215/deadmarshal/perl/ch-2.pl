#!/usr/bin/env perl
use strict;
use warnings;
use List::MoreUtils qw(slideatatime);

sub number_placement{
  my ($arr,$count) = @_;
  my $it = slideatatime 1,3,@$arr;
  my $c = 0;
  while(my @vals = $it->()){
    $c++ if $vals[0] == 0 && $vals[-1] == 0;
  }
  $c >= $count;
}

printf "%d\n", number_placement([1,0,0,0,1],1);
printf "%d\n", number_placement([1,0,0,0,1],2);
printf "%d\n", number_placement([1,0,0,0,0,0,0,0,1],3);


#!/usr/bin/env perl
use strict;
use warnings;

my ($count,@arr) =(0,(0) x 5);
penny_piles(\@arr,0,5,5);
print "$count\n";

sub penny_piles{
  my ($arr,$index,$num,$reducednum) = @_;
  return if $reducednum < 0;
  do{$count++; return} if $reducednum == 0;
  my $prev = $index == 0 ? 1 : $arr->[$index-1];
  foreach my $i($prev..$num){
    $arr->[$index] = $i;
    penny_piles($arr,$index+1,$num,$reducednum-$i);
  }
}


#!/usr/bin/perl 
use strict;
use Data::Dumper;
use List::Util qw(min);


#You are given an array of integers, @ints.

#Write a script to return the count of all strong pairs in the given array.
#A pair of integers x and y is called strong pair if it satisfies: 0 < |x - y| < min(x, y)
my @ints = (1, 2, 3, 4, 5);
#my @ints = (5, 7, 1, 7);
my @pairs;
my %seen;
my $key;
my $j;
# 0 < |2-3| < min(2,3)

for(my $i; $i<(scalar @ints); $i++){
    $j = $i+1;
    while($j < (scalar @ints)){
      
      if((abs($ints[$i]-$ints[$j]) > 0) && ((abs($ints[$i]-$ints[$j])) < min($ints[$i],$ints[$j]))){
        $key = $ints[$i].",".$ints[$j];
        if(!exists($seen{$key})){
          $seen{$key} = '';
          push @pairs,[$ints[$i],$ints[$j]];
        }else{}
      }
    $j+=1;
    }
}

foreach(@pairs){
  print Dumper $_;
}
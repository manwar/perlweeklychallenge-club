#!/usr/bin/perl

use strict;
use warnings;

my @array = (1, 4, 3, 2);

my $candies = scalar @array; 
my $size    = $#array;

foreach my $element (1..$size){
    if($array[$element] > $array[$element - 1]){
        $candies = $candies + 1;
    }
}

foreach my $element (0..$size-1){
    if($array[$element] > $array[$element + 1]){
        $candies = $candies + 1;
    }
}
print "Total candies: $candies\n";

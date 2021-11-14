use strict;
use warnings;
##
# You are given an array of positive integers, such 
# that all the numbers appear even number of times except one number.
# Write a script to find that integer.
##
sub find_odd_occurring{
    my %counts;
    for my $x (@_){
        $counts{$x}++;
    }
    for my $x (keys %counts){
        return $x if $counts{$x} % 2 != 0;
    }
}

MAIN:{
    print find_odd_occurring(2, 5, 4, 4, 5, 5, 2) . "\n";
    print find_odd_occurring(1, 2, 3, 4, 3, 2, 1, 4, 4) . "\n";
}
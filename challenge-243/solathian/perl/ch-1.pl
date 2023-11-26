#!usr/bin/perl
use v5.38;

use builtin "indexed";
no warnings "experimental";


# Challenge 243 - 1 - Reverse Pairs
# You are given an array of integers.
# Write a script to return the number of reverse pairs in the given array.
# A reverse pair is a pair (i, j) where: a) 0 <= i < j < nums.length and b) nums[i] > 2 * nums[j].

revPair((1, 3, 2, 3, 1));
revPair((2, 4, 3, 5, 1));

sub revPair(@arr)
{
    my @pairs;

    foreach my ($i, $iVal) (indexed @arr)
    {
        foreach my ($j, $jVal) (indexed @arr)
        {
            # just going with the debug approach, a simple counter would also suffice
            push(@pairs, [$i, $j])      if( $i < $j and $iVal > 2*$jVal);   
        }
    }

    say "Number of pairs: ", scalar @pairs;
}
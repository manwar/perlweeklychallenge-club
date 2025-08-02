#!usr/bin/perl
use v5.38;
use builtin qw(indexed);
no warnings "experimental";


# Challenge 250 - 1 - Smallest Index
# You are given an array of integers, @ints.
# Write a script to find the smallest index i such that i mod 10 == $ints[i] otherwise return -1.


small(0,1,2);                           # 0
small(4, 3, 2, 1);                      # 2
small(1, 2, 3, 4, 5, 6, 7, 8, 9, 0);    # -1

sub small(@array)
{
    my $returnVal = -1;

    foreach my ($index, $elem) (indexed @array)
    {
        if($index % 10 == $elem)
        {
            $returnVal = $index;
            last;
        }
    }
    
    say $returnVal;
    return $returnVal;
}
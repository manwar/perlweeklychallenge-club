#!usr/bin/perl
use v5.36;

# Challenge 217 - 1 - Sorted Matrix

# You are given a n x n matrix where n >= 2.
# Write a script to find 3rd smallest element in the sorted matrix.

sortMatrix ([[3, 1, 2], [5, 2, 4], [0, 1, 3]]);         # 1
sortMatrix ([[2, 1], [4, 5]]);                          # 4
sortMatrix ([[1, 0, 3], [0, 0, 0], [1, 2, 1]]);         # 0

sub sortMatrix($matrixRef)
{
    my @array;
    
    foreach my $subArray (@$matrixRef)
    {
        foreach my $elem (@$subArray)
        {
            push(@array, $elem);
        }
    }
    
    @array = sort @array;
    
    say $array[2];
    
}
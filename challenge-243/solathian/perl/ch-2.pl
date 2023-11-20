#!usr/bin/perl
use v5.38;
use builtin "floor";
no warnings "experimental";

# Challenge 243 - 2 - Floor Sum
# You are given an array of positive integers (>=1).
# Write a script to return the sum of floor(nums[i] / nums[j]) where 0 <= i,j < nums.length. 
# The floor() function returns the integer part of the division.


floorSum(2, 5, 9);
floorSum(7, 7, 7, 7, 7, 7, 7);

sub floorSum(@list)
{
    my $sum;
    
    foreach my ($iVal) (@list)
    {
        foreach my ($jVal) (@list)
        {
            $sum += floor($iVal / $jVal)
        }
    }
    
    say $sum;
}
#!usr/bin/perl -w
use strict;
use warnings;

use feature qw(say signatures);
no warnings qw(experimental);

my $testsEnabled = 0;
# Task 2: Array Degree

# You are given an array of 2 or more non-negative integers.
# Write a script to find out the smallest slice, i.e. contiguous subarray of the original array, having the degree of the given array.
# The degree of an array is the maximum frequency of an element in the array.

sub getMaxDegree(@array)
{
    @array = sort @array;
    my $maxDegree       = 1;
    my $currentDegree   = 1;
    my $lastElem        = -1;
    
    foreach my $elem (@array)
    {
        if($elem == $lastElem )
        {
            $currentDegree++;
            
            if($currentDegree > $maxDegree)
            {
                $maxDegree = $currentDegree;
            }
        }
        else
        {
            $currentDegree = 1;
            $lastElem = $elem;
        }

    }
    return $maxDegree;
}

sub arrayDegree(@array)
{
    my $targetDegree = getMaxDegree(@array);
    my $arrayLength  = @array;
    
    # the length of the test array
    for(my $i = 1; $i < $arrayLength; $i++)
    {
        # create subarrays of $i+1 size
        for(my $offset = 0; $offset + $i  < $arrayLength; $offset++)
        {
            my @subArray    = @array[$offset .. ($offset + $i)];

            if(getMaxDegree(@subArray) == $targetDegree)
            {
                say('(', join(',', @subArray), ')');
                return;
            }
        }
    }
}


# Examples:

my @tArray0 = (1, 3, 3, 2);
arrayDegree(@tArray0)   if($testsEnabled);
# Output: (3,3)

my @tArray1 = (1, 2, 1, 3);
arrayDegree(@tArray1)   if($testsEnabled);
# Output: (1, 2, 1)

my @tArray2 =  (1, 3, 2, 1, 2);
arrayDegree(@tArray2)   if($testsEnabled);
# Output: (2, 1, 2)

my @tArray3 = (1, 1, 2, 3, 2);
arrayDegree(@tArray3)   if($testsEnabled);
# Output: (1, 1)

my @tArray4 = (2, 1, 2, 1, 1);
arrayDegree(@tArray4)   if($testsEnabled);
# Output: (1, 2, 1, 1)

#!usr/bin/perl -w

# Created for perl weekly challenge - 182 - 1

# You are given a list of integers.

# Write a script to find the index of the first biggest number in the list.

use strict;
use warnings;
use Lingua::EN::Numbers::Ordinate;

# sample calls

# my @sampleArray = (5, 2, 9, 1, 7, 6);
# maxIndex(\@sampleArray);

# my @sampleArray = (4, 2, 3, 1, 5, 0);
# maxIndex(\@sampleArray);

# my @sampleArray = (4, 2, 3, 5, 5, 0);
# maxIndex(\@sampleArray);

# my @sampleArray = (12, 12, 3, 5, 5, 0);
# maxIndex(\@sampleArray);


sub maxIndex
{
    my ($arrayRef)  = @_;

    my @sortedArray = sort { $a <=> $b } @$arrayRef;    # sort the array
    my $max         = $sortedArray[-1];                 # get the last element of the array
    my $length      = @$arrayRef;                       # get the length of the array

    for(my $i = 0; $i < $length; $i++)
    {
        if($arrayRef->[$i] == $max) # check if it is the greatest element
        {
            # print the result and break the loop
            print   "Output: $i (as ", ordinate($i+1), " in the list is the greatest number)";
            last;
        }
    }

}

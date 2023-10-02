#!usr/bin/perl
use v5.38;
# Challenge 231 - 1 - Min Max
# You are given an array of distinct integers.
# Write a script to find all elements that is neither minimum nor maximum. Return -1 if you can’t.

minMax(3, 2, 1, 4);  #(3, 2)
minMax(1, 3);        # -1
minMax(2, 1, 3);     # 2

sub minMax(@array)
{  
    if(@array < 3)
    {
        say "-1"
    }
    else
    {
        my ($min, $max) = (sort @array)[0, -1];
        @array          = grep{ $_ ne $min and $_ ne $max } @array;
        say join ', ', @array;
    }
    
}


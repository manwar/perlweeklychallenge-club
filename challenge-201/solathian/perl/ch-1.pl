#!usr/bin/perl
use v5.36;

no warnings "experimental::smartmatch";

# Challange 201 - 1 -  Missing Numbers
# You are given an array of unique numbers.

# Write a script to find out all missing numbers in the range 0..$n where $n is the array size.


# missingNumbers((0,1,3,5));      # Output: 2,4
# missingNumbers((0,1,3));        # Output: 2
# missingNumbers((0,1));          # Output: 2


sub missingNumbers(@array)
{
    my @missing;
    
    for(my $i = 0; $i <= @array; $i++)
    {
        push(@missing, $i)      if( not ($i ~~ @array));
    }

    say "Missing:".join(',', @missing);
}
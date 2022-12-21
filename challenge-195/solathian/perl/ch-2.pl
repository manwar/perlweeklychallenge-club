#!usr/bin/perl
use v5.32;
use warnings;

use List::Util 'max';

use feature 'signatures';
no  warnings 'experimental';    # signatures, smartmatch

# Challange 195 - 2 - Most Frequent Even

# You are given a list of numbers, @list.
# Write a script to find most frequent even numbers in the list. 
# In case you get more than one even numbers then return the smallest even integer. For all other case, return -1.


# mostFreqEven((6,4,4,6,1));
# Output: 4 since there are only two even numbers 4 and 6. They both appears the equal number of times, so pick the smallest.

# mostFreqEven((1,3,5,7));
# Output: -1 since no even numbers found in the list

# mostFreqEven((1,1,2,6,2));
# Output: 2 as there are only 2 even numbers 2 and 6 and of those 2 appears the most.



sub mostFreqEven(@list)
{

    my @even = grep { $_ % 2 == 0 } @list;
    if( @even == 0)
    {
        say -1;
        return;
    }
    
    my $string = join('', @even);
    my @array = ($string =~ tr/0/0/, $string =~ tr/2/2/, $string =~ tr/4/4/, $string =~ tr/6/6/, $string =~ tr/8/8/);


    for(my $i = 0; $i < @array; $i++)
    {
        if($array[$i] == max(@array))
        {
            say $i*2;
            last;
        }
    }
    
} 
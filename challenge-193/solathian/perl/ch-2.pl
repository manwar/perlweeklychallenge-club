#!usr/bin/perl
use v5.32;
use warnings;

use feature 'signatures';
no  warnings 'experimental';

use Clone qw(clone);

# Challange 193 - 2 - Odd String


# You are given a list of strings of same length, @s.
# Write a script to find the odd string in the given list. Use positional value of alphabet starting with 0, i.e. a = 0, b = 1, ... z = 25.
# Find the difference array for each string as shown in the example. Then pick the odd one out.

sub oddString($listRef)
{
    my @differenceArrays;

    foreach my $string (@$listRef)
    {
        my @tempArray;
        my @array = split('', $string);
        
        map($_ = (ord($_) - ord("a")), @array);
        
        for(my $i = 0; $i < $#array; $i++)
        {
            push(@tempArray, ($array[$i + 1] - $array[$i]));
        }

        push(@differenceArrays, join(',', @tempArray));
    }   


    
    for(my $i = 0; $i < @differenceArrays; $i++)
    {
        # save and remove the element from the array
        my $current = clone($differenceArrays[$i]);
        $differenceArrays[$i] =  undef;

        
        # check if the deepcopied array is still present in the difference array, if not then it is odd
        if(not ($current ~~ @differenceArrays))
        {
            say "The difference array for \"". $listRef->[$i] . "\" is odd";
            last;
        }
        
        # restore
        $differenceArrays[$i] = $current; 
    }
    
    say "Did not find Odd element.";
}

# my @s = ("aaa", "bob", "ccc", "ddd");
# oddString(\@s);
# The difference array for "bob" is the odd one.



# my @s2 = ("adc", "wzy", "abc");
# oddString(\@s2);
# The difference array for "abc" is the odd one.
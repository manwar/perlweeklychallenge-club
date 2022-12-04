#!usr/bin/perl
use v5.32;
use warnings;

use feature 'signatures';
no  warnings 'experimental';

use Algorithm::Combinatorics qw(variations_with_repetition);

# Challange 193 - 1 - Binary String
# You are given an integer, $n > 0.
# Write a script to find all possible binary numbers of size $n.

sub binString($n)
{
    my @resultArr;
    
    foreach my $arrRef (variations_with_repetition( ['0', '1'], $n))
    {
        push(@resultArr, join('', @$arrRef));   # re-create the string from the array and push
    }
    
    say join(', ', @resultArr);     # create result string from the collected strings

}

# binString(1);     # 0, 1
# binString(2);     # Output: 00, 11, 01, 10
# binString(3);     # Output: 000, 001, 010, 100, 111, 110, 101, 011
# binString(16);    # ...

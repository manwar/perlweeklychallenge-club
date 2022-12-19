#!usr/bin/perl
use v5.32;
use warnings;

use feature 'signatures';
no  warnings 'experimental';    # signatures, smartmatch

# Challange 195 - 1 - Special Integers

# You are given a positive integer, $n > 0.
# Write a script to print the count of all special integers between 1 and $n.
# An integer is special when all of its digits are unique.

specialInt(15); #  Output: 14 as except 11 all other integers between 1 and 15 are spcial.
specialInt(35); #  Output: 32 as except 11, 22, 33 all others are special.


sub specialInt($number)
{
    my $count;
    
    for(my $i = 1; $i <= $number; $i++)
    {
        next    if( join('', sort( split('', $i))) =~ /00|11|22|33|44|55|66|77|88|99/);

        $count++;
    }
    
    say $count;
}
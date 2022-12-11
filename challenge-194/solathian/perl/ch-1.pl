#!usr/bin/perl
use v5.32;
use warnings;

use feature 'signatures';
no  warnings 'experimental';

# Challange 194 - 1 - Digital Clock
# You are given time in the format hh:mm with one missing digit.
# Write a script to find the highest digit between 0-9 that makes it valid time.

#Assumptions:
# input format can be extended to a correct format
# input only contains one '?'

sub digitalClock($string)
{
    my ($first, $second, $third, $fourth) = $string =~ m"^(\?|\d)(\?|\d):(\?|\d)(\?|\d)$";
    my $returnVal;
    
    #if the first one is missing
    if($first eq '?')
    {
        if($second > 3)
        {
            $returnVal = 1;
        }
        else
        {
            $returnVal = 2;
        }
    }
    elsif($second eq '?')
    {
        if($first eq '2')
        {
            $returnVal = 3;
        }
        else
        {
            $returnVal = 9;
        }
    }
    elsif($third eq '?')
    {
        $returnVal = 5;
    }
    elsif($fourth eq '?')
    {
        $returnVal = 9;
    }
    
    # $string =~ s"\?"$returnVal";
    say $returnVal;
    
}

# digitalClock('?5:00');     # Output: 1
# digitalClock('?3:00');     # Output: 2
# digitalClock('1?:00');     # Output: 9
# digitalClock('2?:00');     # Output: 3
# digitalClock('12:?5');     # Output: 5
# digitalClock('12:5?');     # Output: 9
# digitalClock('?0:59');     # Output: 2
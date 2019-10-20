#!/usr/bin/perl6
use v6;

use Test;

# 30.2
# Write a script to print all possible series of 3 positive numbers, where in each series at least one of the number is even and sum of the three numbers is always 12. For example, 3,4,5.


sub SumsTwelve(*@tri) {
    return True if ( [+] @tri ) == 12; # this will always fullfil condition one of number is even as can only add to twelve is ALL even or TWO odd. sum of all odd or one odd can never an even number!
    return False;
}

for 1..10 -> $a {
    for 1..11-$a -> $b {
        for 1..12-$b-$a -> $c {
            say "$a,$b,$c" if SumsTwelve($a,$b,$c);
        }
    }
}

#!/usr/bin/env raku

# I learned about polymod from Kevin Colyer's ch-2.p6 solution last week.
# I like that method for splitting up the number into its digits.

sub MAIN($num1, $num2 where $num1 >= 100 < $num2 <= 999) {
    for ($num1..$num2) -> $num {
        my @digits = (+$num).polymod(10,10);
        if (([-] @digits[0,1]).abs == ([-] @digits[1,2]).abs == 1) {
            say $num;
        }
    }
}

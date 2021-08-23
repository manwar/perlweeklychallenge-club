#!/usr/bin/env raku

# The adjust function adjusts the number if it contains a 1 
# Examples: adjust(111)     = 99
#           adjust(901)     = 900
#           adjust(2731515) = 2730999

# The count-numbers function performs this equivalent algorithm:
# For all digits, subtract 1 and multiply that by 9 raised to the
# power of the log of that digit's place value. Then sum those 
# results. 
# Examples: count-numbers(25)   = 1*9^1 + 4*9^0 = 13
#           count-numbers(7777) = 6*9^3 + 6*9^2 + 6*9^1 + 6*9^0 = 4920  
#           count-numbers(9324) = 8*9^3 + 2*9^2 + 1*9^1 + 3*9^0 = 6006

use Test;
plan 9;

is count-numbers(1),       0;
is count-numbers(15),      8;
is count-numbers(25),      13;
is count-numbers(7777),    4920;
is count-numbers(12345),   6560;
is count-numbers(654321),  323847;
is count-numbers(1230456), 531440;
is count-numbers(9999999), 4782968;
is count-numbers(10**32),  3433683820292512484657849089280;

multi count-numbers($N where * == 1) { 0 }

multi count-numbers($N is copy)
{
    $N = adjust($N);
    my @digits = $N.comb;
    my $count;

    loop 
    {
        return $count unless @digits;
        my $d = @digits.shift;
        next if $d == 0;
        $count += ($d-1) * 9 ** @digits.elems;
    }
}         

sub adjust($N is copy)
{
    my @a = $N.split('1', 2);
    return $N if @a.elems == 1; # $N has no 1s

    @a.tail = 0 ~ 9 x @a.tail.chars;
    return @a.join;
}

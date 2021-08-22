#!/usr/bin/env raku

# count-numbers uses the following algorithm.
# Example: The result of 9324 = 8*9^3 + 2*9^2 + 1*9^1 + 3*9^0 = 6006

# But first, adjust is called.
# Examples: 111     is converted to 99
#           901     is converted to 900
#           2731515 is converted to 2730999
#           A number with no 1s is unchanged

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

    while @digits
    {
        my $d = @digits.shift;
        next if $d == 0;
        $count += ($d-1) * 9 ** @digits.elems;
    }

    $count;
}         

sub adjust($N is copy)
{
    my @a = $N.split('1', 2);

    return $N if @a.elems == 1; # no 1s

    @a.tail = 0 ~ 9 x @a.tail.chars;

    return @a.tail.substr(1) unless @a.head; # first digit is 1

    return @a.join;
}

#!/usr/bin/perl6

# Niven numbers are also known as Harshad numbers.  Coincidentally Harshad is
# my patronym.

# This script is dedicated to the memory of my father Dr. Harshad V. Vyas
# (1935-2019)

say 0;

for 1 .. 50 -> $number {
    if $number % $number.comb.sum == 0 {
        say $number;
    }
}

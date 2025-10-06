#!/usr/bin/env perl

use v5.38;
use Test::More;

my @examples = (
    ["a0b1c2",  "0a1b2c" ],
    ["abc12",   "a1b2c"  ],
    ["0a2b1c3", "0a1b2c3"],
    ["1a23",    ""       ],
    ["ab123",   "1a2b3"  ],
);

for (@examples) {
    is(balance_string($_->[0]), $_->[1]);
}

done_testing;

sub balance_string {
    my $s = shift;                           # Get the input string from arguments
    my @d = sort grep /\d/, split //, $s;    # Extract all digits and sort them
    my @l = sort grep /\D/, split //, $s;    # Extract all letters and sort them

    return "" if abs(@d - @l) > 1;           # Return empty string if impossible

    @d > @l ?                                # If more digits than letters:
        join "",                             #   Join all elements into a string
        map $d[$_] . ($l[$_] || ""),         #   For each index: digit + letter (or empty if no letter)
        0..$#d                               #   Iterate through all digit indices
    :                                        # Else:
    @l > @d ?                                # If more letters than digits:
        join "",                             #   Join all elements into a string
        map $l[$_] . ($d[$_] || ""),         #   For each index: letter + digit (or empty if no digit)
        0..$#l                               #   Iterate through all letter indices
    :                                        # Else (equal counts):
    $d[0] lt $l[0] ?                         # If first digit < first letter lexicographically:
        join "",                             #   Join all elements into a string
        map $d[$_] . $l[$_],                 #   For each index: digit + letter
        0..$#d                               #   Iterate through all indices (both arrays same size)
    :                                        # Else:
        join "",                             #   Join all elements into a string
        map $l[$_] . $d[$_],                 #   For each index: letter + digit
        0..$#d                               #   Iterate through all indices (both arrays same size)
}

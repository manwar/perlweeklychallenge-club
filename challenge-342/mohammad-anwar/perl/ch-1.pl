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
    my $s = shift;
    # Extract all digits and sort them
    my @d = sort grep /\d/, split //, $s;
    # Extract all letters and sort them
    my @l = sort grep /\D/, split //, $s;

    # Return empty string if impossible
    return "" if abs(@d - @l) > 1;

    # If more digits than letters:
    @d > @l ?
        #   Join all elements into a string
        join "",
        #   For each index: digit + letter (or empty if no letter)
        map $d[$_] . ($l[$_] || ""),
        #   Iterate through all digit indices
        0..$#d
    :
    # If more letters than digits:
    @l > @d ?
        #   Join all elements into a string
        join "",
        #   For each index: letter + digit (or empty if no digit)
        map $l[$_] . ($d[$_] || ""),
        #   Iterate through all letter indices
        0..$#l
    # Else (equal counts):
    :
    # If first digit < first letter lexicographically:
    $d[0] lt $l[0] ?
        #   Join all elements into a string
        join "",
        #   For each index: digit + letter
        map $d[$_] . $l[$_],
        #   Iterate through all indices (both arrays same size)
        0..$#d
    :   # Else:
        #   Join all elements into a string
        join "",
        #   For each index: letter + digit
        map $l[$_] . $d[$_],
        #   Iterate through all indices (both arrays same size)
        0..$#d
}

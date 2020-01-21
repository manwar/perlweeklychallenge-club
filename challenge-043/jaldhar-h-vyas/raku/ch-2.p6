#!/usr/bin/perl6

multi sub MAIN($base where { ( 1, 2, 3, 6).any != $_; }) { #= integer base except 1,2,3 or 6
    say (0 + ($base - 4) * ($base ** ($base - 1)) + (2 * $base ** ($base - 2)) +
        ($base ** ($base - 3)) + $base ** 3).base($base);
}
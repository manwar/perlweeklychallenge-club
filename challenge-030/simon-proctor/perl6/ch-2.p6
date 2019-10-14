#!/usr/bin/env perl6

use v6;

#| Print all the series of 3 numbers where a+b+c == 12 and at least 1 value is even
sub MAIN() {
    .join(",").say for (1..9).combinations(3).grep( { [<] $_ } ).grep( { 12 == [+] $_ } ).grep( { any($_) %% 2 } );
}

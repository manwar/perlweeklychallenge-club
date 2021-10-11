#!/usr/bin/env raku

#| Find the first n (default 5) Pandigital Numbers in Base 10
sub MAIN ( UInt \n = 5 ) {
    .say for (1023456789..*).grep( { $_.comb (==) ('0'..'9')} )[^n];
}

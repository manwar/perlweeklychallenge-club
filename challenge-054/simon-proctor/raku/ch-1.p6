#!/usr/bin/env raku

use v6;

#| Print the kth permutation of the numbers from 1 to n
multi sub MAIN( UInt \n, Int \k where { 1 <= k <= [*] 1..n } ) {
    (1..n).permutations[k-1].join("").say;
}

multi sub MAIN( *@ ) is hidden-from-USAGE {
    say $*USAGE;
    say "\nPlease ensure k is between 1 and n!";
}

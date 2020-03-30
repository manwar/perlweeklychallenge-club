#!/usr/bin/env raku

use v6;

#| Print the kth permutation of the numbers from 1 to n
sub MAIN( UInt \n, Int \k where * >= 1 ) {
    (1..n).permutations[k-1].join("").say;
}

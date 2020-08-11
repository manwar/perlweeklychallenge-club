#!/usr/bin/env perl6

# ch-1.p6 - kth Permutation
#
# Ryan Thompson <rjt@cpan.org>

sub MAIN( Int $n = 3, Int $k = 4 ) {
    say (1..$n).permutations[$k-1];
}

#!/usr/bin/env perl6

# Usage:   ch-1.p6 $T @L
# Example: ch-1.p6 0 -25 -10 -7 -3 2 4 8 10

sub MAIN($T, *@L) {
    say @L.sort.combinations(3).grep(*.sum == $T);
}

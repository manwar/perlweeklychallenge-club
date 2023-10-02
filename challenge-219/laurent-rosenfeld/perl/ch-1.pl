use strict;
use warnings;
use feature 'say';

sub sorted_squares {
    return sort {$a <=> $b} map $_ * $_, @_;
}

for my $test ([-2, -1, 0, 3, 4], [5, -4, -1, 3, 6]) {
    printf "%-15s => ", "@$test";
    say join " ", sorted_squares @$test;
}

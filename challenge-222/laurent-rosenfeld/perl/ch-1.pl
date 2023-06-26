use strict;
use warnings;
use feature 'say';

sub matching_members {
    my @sorted = sort { $a <=> $b } @_;
    my $match = 0;
    for my $i (0..$#sorted) {
        $match++ if $_[$i] == $sorted[$i];
    }
    return $match;
}

for my $test ([<1 1 4 2 1 3>], [<5 1 2 3 4>], [<1 2 3 4 5>]) {
    printf "%-12s => ", "@$test";
    say matching_members @$test;
}

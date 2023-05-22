use strict;
use warnings;
use feature 'say';

sub mycmp {
    my ($i, $j) = @_;
    return $i.$j <=> $j.$i;
}

sub reorder {
    return join "", sort { mycmp ($b, $a) } @_;
}

for my $test ([1, 23], [10, 3, 2], [31, 2, 4, 10],
    [5, 11, 4, 1, 2], [1, 10], [10, 1],
    [1, 10], [1, 100], [100, 1]) {
    printf "%-15s => ", "@$test";
    say reorder @$test;
}

use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run(@ints) {
    return 0 if scalar(@ints) < 2;
    my @sorted = sort { $a <=> $b } @ints;

    my $diff = $sorted[1] - $sorted[0];
    for (my $i = 1; $i < scalar(@sorted) - 1; $i++) {
        return 0 if $sorted[$i+1] - $sorted[$i] != $diff;
    }
    return 1;
}


is run(1, 3, 5, 7, 9), 1, 'Example 1';
is run(9, 1, 7, 5, 3), 1, 'Example 2';
is run(1, 2, 4, 8, 16), 0, 'Example 3';
is run(5, -1, 3, 1, -3), 1, 'Example 4';
is run(1.5, 3, 0, 4.5, 6), 1, 'Example 5';

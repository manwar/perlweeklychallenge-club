use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run(@ints) {
    my @sorted = sort { $a <=> $b } @ints;
    my $diffing_indices = [];

    for (my $i = 0; $i < scalar(@ints); $i++) {
        push @$diffing_indices, $i if ($ints[$i] != $sorted[$i]);
    }
    return $diffing_indices;
}

is_deeply(run(5, 2, 4, 3, 1), [0, 2, 3, 4], "Example 1");
is_deeply(run(1, 2, 1, 1, 3), [1, 3], "Example 2");
is_deeply(run(3, 1, 3, 2, 3), [0, 1, 3], "Example 3");

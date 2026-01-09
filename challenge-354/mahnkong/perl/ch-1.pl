use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run(@ints) {
    my @sorted = sort { $a <=> $b } @ints;
    my $min_diff = undef;
    my @result;

    for (my $i = 0; $i < scalar(@sorted) - 1; $i++) {
        my $diff = abs($sorted[$i -1] - $sorted[$i]);
        $min_diff = $diff if !defined $min_diff || $diff < $min_diff;
    }

    for (my $i = 0; $i < scalar(@sorted); $i++) {
        for (my $j = 0; $j < scalar(@sorted); $j++) {
            next if $i == $j;
            if ($sorted[$i] < $sorted[$j] && abs($sorted[$j] - $sorted[$i]) == $min_diff) {
                push @result, [$sorted[$i], $sorted[$j]];
            }
        }
    }
    return [ @result ];
}

is_deeply( run(4, 2, 1, 3), [[1, 2], [2, 3], [3, 4]], 'Example 1');
is_deeply( run(10, 100, 20, 30), [[10, 20], [20, 30]], 'Example 2');
is_deeply( run(-5, -2, 0, 3), [[-2, 0]], 'Example 3');
is_deeply( run(8, 1, 15, 3), [[1, 3]], 'Example 4');
is_deeply( run(12, 5, 9, 1, 15), [[9, 12], [12, 15]], 'Example 5');

use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($matrix, $times) {
    return $matrix if $times < 1;
    for (my $i = 1; $i <= $times; $i++) {
        my @rule2;
        for (my $r = 0; $r < scalar(@$matrix); $r++) {
            my $row = $matrix->[$r];
            my $last = pop @$row;
            push @rule2, $last;
            unshift @$row, $last;
        }
        for (my $r = 0; $r < scalar(@$matrix); $r++) {
            $matrix->[ $r + 1 == scalar(@$matrix) ? 0 : $r + 1 ]->[0] = $rule2[$r];
        }
    }
    return $matrix;
}

is_deeply(run([[1, 2, 3], [4, 5, 6], [7, 8, 9]], 1), [[9, 1, 2], [3, 4, 5], [6, 7, 8]], 'Example 1');
is_deeply(run([[10, 20], [30, 40]], 1), [[40, 10], [20, 30]], 'Example 2');
is_deeply(run([[1, 2], [3, 4], [5, 6]], 1), [[6, 1], [2, 3], [4, 5]], 'Example 3');
is_deeply(run([[1, 2, 3], [4, 5, 6]], 5), [[2, 3, 4], [5, 6, 1]], 'Example 4');
is_deeply(run([[1, 2, 3, 4]], 1), [[4, 1, 2, 3]], 'Example 5');

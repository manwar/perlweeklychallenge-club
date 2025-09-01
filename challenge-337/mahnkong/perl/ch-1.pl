use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run(@nums) {
    my @result;
    for (my $i = 0; $i <= $#nums; $i++) {
        $result[$i] = 0;
        for (my $j = 0; $j <= $#nums; $j++) {
            next if $i == $j;
            $result[$i] += 1 if $nums[$i] >= $nums[$j];
        }
    }

    return [ @result ];
}

is_deeply(run(6, 5, 4, 8), [2, 1, 0, 3], "Example 1");
is_deeply(run(7, 7, 7, 7), [3, 3, 3, 3], "Example 2");
is_deeply(run(5, 4, 3, 2, 1), [4, 3, 2, 1, 0], "Example 3");
is_deeply(run(-1, 0, 3, -2, 1), [1, 2, 4, 0, 3], "Example 4");
is_deeply(run(0, 1, 1, 2, 0), [1, 3, 3, 4, 1], "Example 5");

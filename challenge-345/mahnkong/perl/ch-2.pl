use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run(@ints) {
    my @seen;
    my @ans;
    my $streak = 0;

    foreach my $int (@ints) {
        if ($int == -1) {
            push @ans, $streak < scalar(@seen) ? $seen[$streak] : -1;
            $streak += 1;
        } else {
            unshift @seen, $int if $int > 0;
            $streak = 0;
        }
    }

    return [ @ans ];
}

is_deeply(run(5, -1, -1), [5, -1], "Example 1");
is_deeply(run(3, 7, -1, -1, -1), [7, 3, -1], "Example 2");
is_deeply(run(2, -1, 4, -1, -1), [2, 4, 2], "Example 3");
is_deeply(run(10, 20, -1, 30, -1, -1), [20, 30, 20], "Example 4");
is_deeply(run(-1, -1, 5, -1), [-1, -1, 5], "Example 5");

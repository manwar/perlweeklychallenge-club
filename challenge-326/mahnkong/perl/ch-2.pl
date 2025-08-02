use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run(@ints) {
    return undef if scalar(@ints) % 2 != 0;

    my @result;
    while (scalar(@ints) > 0) {
        my $m = shift @ints;
        my $v = shift @ints;
        push @result, $v for (1 .. $m);
    }

    return [ @result ];
}

is_deeply(run(1, 3, 2, 4), [3, 4, 4], "Example 1");
is_deeply(run(1, 1, 2, 2), [1, 2, 2], "Example 2");
is_deeply(run(3, 1, 3, 2), [1, 1, 1, 2, 2, 2], "Example 3");

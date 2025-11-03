use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run(@ints) {
    my @peaks;
    for (my $i = 0; $i < scalar(@ints); $i++) {
        if ((! exists $ints[$i-1] || $ints[$i] > $ints[$i-1]) && (! exists $ints[$i+1] || $ints[$i] > $ints[$i+1])) {
            push @peaks, $i;
        }
    }
    return [ @peaks ];
}

is_deeply(run(1,3,2), [1], "Example 1");
is_deeply(run(2,4,6,5,3), [2], "Example 2");
is_deeply(run(1,2,3,2,4,1), [2,4], "Example 3");
is_deeply(run(5,3,1), [0], "Example 4");
is_deeply(run(1,5,1,5,1,5,1), [1,3,5], "Example 5");

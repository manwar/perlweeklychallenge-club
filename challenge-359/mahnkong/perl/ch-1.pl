use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($int) {
    my $persistence = 0;

    while ($int >= 10) {
        my $digital_root = 0;
        foreach my $i (split (//, $int)) {
            $digital_root += $i;
        }
        $int = $digital_root;
        $persistence += 1;
    }

    return [ $persistence, $int ];
}

is_deeply(run(38), [2, 2], 'Example 1');
is_deeply(run(7), [0, 7], 'Example 2');
is_deeply(run(999), [2, 9], 'Example 3');
is_deeply(run(1999999999), [3, 1], 'Example 4');
is_deeply(run(101010), [1, 3], 'Example 5');

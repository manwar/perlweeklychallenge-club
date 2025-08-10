use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run(@ints) {
    for (my $i = 0; $i <= $#ints; $i++) {
        if ($ints[$i] == 0 && exists($ints[$i + 1])) {
            for (my $j = $#ints; $j > $i; $j--) {
                $ints[$j] = $ints[$j-1];
            }
            $i+=1;
        }
    }
    return \@ints;
}

is_deeply(run(1, 0, 2, 3, 0, 4, 5, 0), [1, 0, 0, 2, 3, 0, 0, 4], "Example 1");
is_deeply(run(1, 2, 3), [1, 2, 3], "Example 2");
is_deeply(run(1, 2, 3, 0), [1, 2, 3, 0], "Example 3");
is_deeply(run(0, 0, 1, 2), [0, 0, 0, 0], "Example 4");
is_deeply(run(1, 2, 0, 3, 4), [1, 2, 0, 0, 3], "Example 5");

use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run(@ints) {
    my $sum = 0;
    for (my $i = 1; $i <= scalar(@ints); $i +=2) {
        my $start = 0;
        while ($start + $i <= scalar(@ints)) {
            my $end = $start + $i-1;
            for my $e (@ints[$start..$end]) {
                $sum += $e;
            }
            $start +=1;
        }
    }
    return $sum;
}

is(run(2, 5, 3, 6, 4), 77, "Example 1");
is(run(1, 3), 4, "Example 2");

use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run($ints, $n) {
    my $max_avg = undef;
    for (my $i = 0; $i <= scalar(@$ints) - $n; $i++) {
        my $end = $i+$n-1;
        my $sum;
        foreach my $e (@$ints[$i..$end]) {
            $sum += $e;
        }
        my $avg = $sum / $n;
        $max_avg = $avg if ! defined $max_avg || $avg > $max_avg;
    }
    return $max_avg;
}

is(run([1, 12, -5, -6, 50, 3], 4), 12.75, "Example 1");
is(run([5], 1), 5, "Example 2");

use strict;
use warnings;
use feature 'signatures';
use Test::More 'no_plan';

sub run(@binary) {
    my $max = 0;
    my $current = 0;
    for (my $i = 0; $i <= $#binary; $i++) {
        $current += 1 if ($binary[$i] == 1);
        if ($binary[$i] == 0 || $i == $#binary) {
            $max = $current if $current > $max;
            $current = 0;
        }
    }
    return $max;
}

is(run(0, 1, 1, 0, 1, 1, 1), 3, "Example 1");
is(run(0, 0, 0, 0), 0, "Example 2");
is(run(1, 0, 1, 0, 1, 1), 2, "Example 3");
